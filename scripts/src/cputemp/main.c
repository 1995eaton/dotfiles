#include <stdio.h>
#include <string.h>
#include <stdlib.h>
#include <sensors/sensors.h>

int main(void) {
  sensors_init(NULL);
  const sensors_chip_name *match;
  const sensors_feature *feat;
  const sensors_subfeature *subf;
  int nrm, nrf, nrs;
  int total = 0,
      ncpus = 0;
  for (nrm = 0; (match = sensors_get_detected_chips(0, &nrm)) != NULL;) {
    for (nrf = 0; (feat = sensors_get_features(match, &nrf)) != NULL;) {
      char *label = sensors_get_label(match, feat);
      if (strstr(label, "Core") == NULL) {
        free(label);
        continue;
      }
      for (nrs = 0; (subf = sensors_get_all_subfeatures(match, feat, &nrs)) != NULL;) {
        double value;
        sensors_get_value(match, subf->number, &value);
        if (subf->type == SENSORS_SUBFEATURE_TEMP_INPUT) {
          ncpus++;
          total += value;
        }
      }
      free(label);
    }
  }
  printf("%.1lf°C\n", total / (double) ncpus);
  return 0;
}
