#include <stdio.h>
#include <stdarg.h>
#include <limits.h>
#include <getopt.h>
#include <stdlib.h>
#include <string.h>
#include <ctype.h>
#include <fcntl.h>
#include <unistd.h>

#define PROGRAM_NAME "cpupower"

typedef struct {
  int id;
  char *arg;
} opt_t;

typedef opt_t *array_t;

#include "array.c"

const char CPUPATH[] = "/sys/devices/system/cpu";
int CPUS_AVAILABLE;

static struct option long_options[] = {
  {"set",      required_argument, 0, 's'},
  {"help",     no_argument,       0, 'h'},
  {"info",     no_argument,       0, 'i'},
  {"turbo",    required_argument, 0, 't'},
  {"percent",  required_argument, 0, 'p'},
  {"cpu",      required_argument, 0, 'c'},
  {"governor", required_argument, 0, 'g'},
  {"monitor",  no_argument,       0, 'm'},
  {"min",      required_argument, 0,  80},
  {"max",      required_argument, 0,  81},
  {"high",     no_argument,       0,  82},
  {"low",      no_argument,       0,  83}
};

char *format(char *template, ...) {
  va_list va;
  va_start(va, template);
  char *buffer = calloc(512, 1);
  vsprintf(buffer, template, va);
  va_end(va);
  return buffer;
}

void show_help() {
puts(
"Usage: ./"PROGRAM_NAME" [OPTION...]\n\n"
"   -h --help                show this message\n"
"      --info                show cpu frequency info\n"
"   -g --governor=GOVERNOR   set the cpu power governor\n"
"      --min=FREQUENCY       set the minimum cpu frequency (GHz)\n"
"      --max=FREQUENCY       set the maximum cpu frequency (GHz)\n"
"      --high                set the cpu governor to the performance preset\n"
"      --low                 set the cpu governor to the powersave preset at the lowest frequency\n"
"\n POWERSAVE GOVERNOR FLAGS:\n"
"   -s --set=FREQUENCY       set the maximum frequency for all cores (GHz)\n"
"   -t --turbo=[0..1]        1 enables cpu turbo boost, 0 disables\n"
"   -p --percent=[0..100]    set the maximum cpu frequency as a percentage\n"
);
exit(EXIT_FAILURE);
}

void show_error(char *message, int show_more_info) {
  printf("%s: %s\n", PROGRAM_NAME, message);
  if (show_more_info) {
    puts("Try '"PROGRAM_NAME" --help' for more information.");
  }
  exit(EXIT_FAILURE);
}

void write_file(const char *file_name, const char *string, int oflag) {
  int fd = open(file_name, oflag);
  if (fd == -1) {
    return;
  }
  write(fd, string, strlen(string) * sizeof(char));
  write(fd, "\n", sizeof(char));
  close(fd);
}

void write_value(const char *pathname, const char *value) {
  char *file_path = (char*) malloc(PATH_MAX * sizeof(char));
  memset(file_path, 0, strlen(file_path));
  sprintf(file_path, "%s%s", CPUPATH, pathname);
  write_file(file_path, value, O_WRONLY);
  free(file_path);
}

char *read_file(const char *pathname) {
  char *file_path = (char*) malloc(PATH_MAX * sizeof(char));
  char *buffer = (char*) malloc(PATH_MAX * sizeof(char));
  memset(buffer, 0, PATH_MAX);
  memset(file_path, 0, PATH_MAX);
  sprintf(file_path, "%s%s", CPUPATH, pathname);
  if (access(file_path, F_OK) == -1) {
    strcat(buffer, "NA ");
    free(file_path);
    return buffer;
  }
  int fd = open(file_path, O_RDONLY);
  if (fd == -1) {
    show_error(format("error reading from '%s': are you running with sudo priviledges?", file_path), 0);
  }
  read(fd, buffer, PATH_MAX);
  close(fd);
  free(file_path);
  if (buffer[strlen(buffer)-1] == '\n') {
    buffer[strlen(buffer) - 1] = '\0';
  }
  return buffer;
}

int to_integer(char *value) {
  int result;
  sscanf(value, "%d", &result);
  return result;
}

int get_max_freq() {
  char *data = read_file("/intel_pstate/max_perf_pct");
  int max = to_integer(data);
  free(data);
  return max;
}

int get_min_freq() {
  char *data = read_file("/intel_pstate/min_perf_pct");
  int max = to_integer(data);
  free(data);
  return max;
}

void set_max_freq(char *freq, int N) {
  char freq_line[80];
  double freq_db;
  sscanf(freq, "%lf", &freq_db);
  freq_db *= 1e6;
  int freq_i = freq_db;
  char *real_freq = calloc(80, 1);
  sprintf(real_freq, "%d", freq_i);
  sprintf(freq_line, "/cpu%d/cpufreq/scaling_max_freq", N);
  write_value(freq_line, real_freq);
  free(real_freq);
}

void set_min_freq(char *freq, int N) {
  char freq_line[80];
  double freq_db;
  sscanf(freq, "%lf", &freq_db);
  freq_db *= 1e6;
  int freq_i = freq_db;
  char *real_freq = calloc(80, 1);
  sprintf(real_freq, "%d", freq_i);
  sprintf(freq_line, "/cpu%d/cpufreq/scaling_min_freq", N);
  write_value(freq_line, real_freq);
  free(real_freq);
}

double parse_number(const char *value) {
  double digits;
  int length;
  sscanf(value, "%lf%n", &digits, &length);
  if (strlen(value) != length) {
    show_error(format("invalid number '%s'", value), 0);
  }
  return digits;
}

void get_cpus_available() {
  char *data = read_file("/possible");
  char *split = strrchr(data, '-');
  if (split == NULL) {
    split = data;
  } else {
    split++;
  }
  sscanf(split, "%d", &CPUS_AVAILABLE);
  CPUS_AVAILABLE++;
}

void enable_cpus(int *cpus) {
  char cpu_str[40];
  memset(cpu_str, 0, 40);
  for (int i = 1; i < CPUS_AVAILABLE; i++) {
    sprintf(cpu_str, "/cpu%d/online", i);
    write_value(cpu_str, cpus[i] ? "1" : "0");
  }
}

void set_governor(char *value) {
  char cpu_str[40];
  memset(cpu_str, 0, 40);
  for (int i = 0; i < CPUS_AVAILABLE; i++) {
    sprintf(cpu_str, "/cpu%d/cpufreq/scaling_governor", i);
    write_value(cpu_str, value);
  }
}

typedef struct {
  char *status;
  char *governor;
  double freq;
} cpuinfo_t;

cpuinfo_t *get_cpu_info(int N) {
  if (N < 0 || N >= CPUS_AVAILABLE) {
    return NULL;
  }
  cpuinfo_t *result = (cpuinfo_t*) malloc(sizeof(cpuinfo_t));
  memset(result, 0, sizeof(cpuinfo_t));
  char freq_line[80],
       governor_line[80];
  sprintf(freq_line, "/cpu%d/cpufreq/cpuinfo_cur_freq", N);
  sprintf(governor_line, "/cpu%d/cpufreq/scaling_governor", N);
  result->status = calloc(8, 1);
  if (N > 0) {
    char status_line[80];
    sprintf(status_line, "/cpu%d/online", N);
    char *status_info = read_file(status_line);
    result->status = *status_info == '0' ? "offline" : "online";
  } else {
    strcat(result->status, "online");
  }
  char *freq_info = read_file(freq_line);
  result->governor = read_file(governor_line);
  sscanf(freq_info, "%lf", &result->freq);
  free(freq_info);
  return result;
}

int *parse_int_list(char *_value) {
  char *value = malloc(strlen(_value) + 1);
  memset(value, 0, strlen(_value) + 1);
  memcpy(value, _value, strlen(_value));
  strcat(value, "\n");
  int *data = (int*) malloc(CPUS_AVAILABLE * sizeof(int));
  memset(data, 0, CPUS_AVAILABLE * sizeof(int));
  char *buffer = (char*) calloc(512, sizeof(char));
  int begin = -1, end = CPUS_AVAILABLE;
  int index = 0;
  char *vp = value;
  while ((index = strcspn(vp, ",\n")) != -1 && index < strlen(vp)) {
    memset(buffer, 0, strlen(buffer));
    memcpy(buffer, vp, index);
    vp += index + 1;
    if (strchr(buffer, '-') == NULL) {
      sscanf(buffer, "%d", &begin);
      data[begin] = 1;
    } else {
      sscanf(buffer, "%d-%d", &begin, &end);
      if (begin < 0) {
        begin = 0;
      }
      for (int i = begin; i < CPUS_AVAILABLE && i <= end; i++) {
        data[i] = 1;
      }
    }
  }
  free(value);
  return data;
}

void show_info() {
  printf("CPU_MIN_PERC:  %d%%\n"
         "CPU_MAX_PERC:  %d%%\n"
         "CPU_MIN_FREQ:  %s\n"
         "CPU_MAX_FREQ:  %s\n"
         "GOVERNORS:     %s\n",
         get_max_freq(), get_min_freq(),
         read_file("/cpu0/cpufreq/scaling_min_freq"),
         read_file("/cpu0/cpufreq/scaling_max_freq"),
         read_file("/cpu0/cpufreq/scaling_available_governors"));
  for (int i = 0; i < CPUS_AVAILABLE; i++) {
    cpuinfo_t *info = get_cpu_info(i);
    printf("CPU%d: %7s, %.2lfGHz, %s\n", i, info->status, info->freq / 1e6, info->governor);
    free(info->governor);
    free(info);
  }
}

void clear_state() {
  write_value("/intel_pstate/min_perf_pct", "0");
  write_value("/intel_pstate/max_perf_pct", "0");
  set_governor("powersave");
  write_value("/intel_pstate/min_perf_pct", "0");
  write_value("/intel_pstate/max_perf_pct", "100");
}

int main(int argc, char **argv) {
  int option_index,
      digit_option;
  get_cpus_available();

  Array arguments = create_array();

  for (int c; (c = getopt_long(argc, argv, ":ip:s:t:p:c:g:hm", long_options, &option_index)) != -1;) {
    switch (c) {
      case '?':
      case '\0':
        show_error(format("unrecognized options '%s'", argv[optind-1]), 1);
        break;
      case ':':
        show_error(format("option requires an argument '%s'", argv[optind-1]), 1);
        break;
    }
    opt_t *opt = calloc(1, sizeof(opt_t));
    opt->id = c;
    opt->arg = optarg == NULL ? "" : optarg;
    array_push(&arguments, opt);
  }

  if (arguments.length == 0) {
    show_help();
  }

  char *ids = calloc(arguments.length, 1);
  char *idsp = ids;
  for (int i = 0; i < arguments.length; i++) {
    opt_t *opt = array_get(&arguments, i);
    if (strchr(ids, opt->id) != NULL) {
      show_error("duplicate argument", 0);
    }
    if (opt->id == 'm' && arguments.length > 1) {
      show_error("invalid argument combination", 1);
    }
    *idsp++ = opt->id;
  }

  idsp = NULL;
  free(ids);

  for (int i = 0; i < arguments.length; i++) {
    opt_t *opt = array_get(&arguments, i);
    switch (opt->id) {
      case 'p':
        digit_option = parse_number(opt->arg);
        if (digit_option < 0 || digit_option > 100) {
          show_error(format("invalid -p argument '%s'", opt->arg), 1);
        }
        clear_state();
        set_governor("powersave");
        for (int i = 0; i < CPUS_AVAILABLE; i++) {
          set_min_freq("0", i);
          set_max_freq(opt->arg, i);
        }
        write_value("/intel_pstate/min_perf_pct", "0");
        write_value("/intel_pstate/max_perf_pct", opt->arg);
        break;
      case 's':
        clear_state();
        set_governor("powersave");
        parse_number(opt->arg);
        for (int i = 0; i < CPUS_AVAILABLE; i++) {
          set_max_freq(opt->arg, i);
          set_min_freq(opt->arg, i);
        }
        break;
      case 't':
        if (opt->arg[0] == '1') {
          write_value("/intel_pstate/no_turbo", "0");
        } else if (opt->arg[0] == '0') {
          write_value("/intel_pstate/no_turbo", "1");
        } else {
          show_error(format("invalid -t argument '%s'", opt->arg), 1);
        }
        break;
      case 'g':
        set_governor(opt->arg);
        break;
      case 'c':
        enable_cpus(parse_int_list(opt->arg));
        break;
      case 'i':
        show_info();
        break;
      case 'm':
        while (1) {
          system("clear");
          show_info();
          sleep(2);
        }
        break;
      case 80:
        clear_state();
        set_governor("powersave");
        if (parse_number(opt->arg) < 0) {
          show_error(format("invalid --min argument '%s'", opt->arg), 1);
        }
        for (int i = 0; i < CPUS_AVAILABLE; i++) {
          set_min_freq(opt->arg, i);
        }
        break;
      case 81:
        clear_state();
        set_governor("powersave");
        if (parse_number(opt->arg) < 0) {
          show_error(format("invalid --max argument '%s'", opt->arg), 1);
        }
        for (int i = 0; i < CPUS_AVAILABLE; i++) {
          set_max_freq(opt->arg, i);
        }
        break;
      case 82:
        clear_state();
        set_governor("performance");
        for (int i = 0; i < CPUS_AVAILABLE; i++) {
          write_value(format("/cpu%d/cpufreq/scaling_max_freq"),
              read_file(format("/cpu%d/cpufreq/cpuinfo_max_freq")));
          write_value(format("/cpu%d/cpufreq/scaling_min_freq"),
              read_file(format("/cpu%d/cpufreq/cpuinfo_max_freq")));
        }
        break;
      case 83:
        clear_state();
        for (int i = 0; i < CPUS_AVAILABLE; i++) {
          write_value(format("/cpu%d/cpufreq/scaling_max_freq"),
              read_file(format("/cpu%d/cpufreq/cpuinfo_min_freq")));
          write_value(format("/cpu%d/cpufreq/scaling_min_freq"),
              read_file(format("/cpu%d/cpufreq/cpuinfo_min_freq")));
        }
        write_value("/intel_pstate/min_perf_pct", "0");
        write_value("/intel_pstate/max_perf_pct", "0");
        break;
      case 'h':
      case '?':
      default:
        show_help();
    }
  }
  return 0;
}
