#include <stdio.h>
#include <math.h>
#include <stdlib.h>

#define LAMBDA(RETURN_TYPE, BODY) ({ RETURN_TYPE __fn__ BODY __fn__; })

#define __NARG__(...)  __NARG_I_(__VA_ARGS__,__RSEQ_N())
#define __NARG_I_(...) __ARG_N(__VA_ARGS__)
#define __ARG_N( \
    _1,  _2,  _3,  _4,  _5,  _6,  _7,  _8,  _9, _10,  \
   _11, _12, _13, _14, _15, _16, _17, _18, _19, _20,  \
   _21, _22, _23, _24, _25, _26, _27, _28, _29, _30,  \
   _31, _32, _33, _34, _35, _36, _37, _38, _39, _40,  \
   _41, _42, _43, _44, _45, _46, _47, _48, _49, _50,  \
   _51, _52, _53, _54, _55, _56, _57, _58, _59, _60,  \
   _61, _62, _63, N, ...) N
#define __RSEQ_N() \
   63, 62, 61, 60,                          \
   59, 58, 57, 56, 55, 54, 53, 52, 51, 50,  \
   49, 48, 47, 46, 45, 44, 43, 42, 41, 40,  \
   39, 38, 37, 36, 35, 34, 33, 32, 31, 30,  \
   29, 28, 27, 26, 25, 24, 23, 22, 21, 20,  \
   19, 18, 17, 16, 15, 14, 13, 12, 11, 10,  \
   9, 8, 7, 6, 5, 4, 3, 2, 1, 0

#define _VFUNC_(name, n) name##n
#define _VFUNC(name, n) _VFUNC_(name, n)
#define VFUNC(func, ...) _VFUNC(func, __NARG__(__VA_ARGS__)) (__VA_ARGS__)

#define VEC_INITIAL_CAP 32
#define VEC_RESIZE_RATIO 1.5

#define VEC_T_2(T, C) \
  typedef struct C { \
    T *data; \
    size_t len, cap; \
    void (*free) (T); \
  } C;
#define VEC_T_1(T) \
  struct { \
    T *data; \
    size_t len, cap; \
    void (*free) (T); \
  }
#define vec_t(...) VFUNC(VEC_T_, __VA_ARGS__)

#define vec_set_free(V, F) { \
  (V).free = LAMBDA(void, F); \
}

#define vec_len(V) (V).len

vec_t(void, vec_void_t);

#define VEC_INIT_2(V, F) \
  (V).data = malloc(VEC_INITIAL_CAP * sizeof (*(V).data)); \
  (V).len = 0; \
  (V).cap = VEC_INITIAL_CAP; \
  (V).free = LAMBDA(void, F);
#define VEC_INIT_1(V) \
  (V).data = malloc(VEC_INITIAL_CAP * sizeof (*(V).data)); \
  (V).len = 0; \
  (V).cap = VEC_INITIAL_CAP; \
  (V).free = NULL;
#define vec_init(...) VFUNC(VEC_INIT_, __VA_ARGS__)

#define VEC_NEW_2(C, F) ({ \
  C result; \
  VEC_INIT_2(result, F); \
  result; \
})

#define VEC_NEW_1(C) ({ \
  C result; \
  VEC_INIT_1(result); \
  result; \
})

#define vec_new(...) VFUNC(VEC_NEW_, __VA_ARGS__)

#define vec_copy(V) ({ \
  __typeof__(V) res = { NULL, vec_len(V), (V).cap, NULL }; \
  res.data = malloc(res.cap * sizeof (*(res).data)); \
  memcpy(res.data, (V).data, res.cap * sizeof (*(res).data)); \
  res; \
})

#define vec_type(V) __typeof__(*((V).data))

#define vec_get(V, I) ((V).data)[I]

#define vec_push(V, E) ({ \
  ++vec_len(V); \
  vec_realloc(V); \
  vec_get(V, vec_len(V) - 1) = E; \
})

#define vec_shift(V) vec_pop_n(V, 0)
#define vec_pop(V) vec_pop_n(V, vec_len(V) - 1)

#define vec_pop_n(V, I) ({ \
  vec_get(V, vec_len(V)) = vec_get(V, I); \
  if (I + 1 != vec_len(V)) { \
    memmove((V).data + (I), (V).data + (I) + 1, (vec_len(V) - (I)) * sizeof (*(V).data)); \
  } \
  vec_len(V)--; \
  vec_get(V, vec_len(V) + 1); \
})

#define vec_indexof(V, E) ({ \
  int index = -1; \
  for (int i = 0; i < vec_len(V); i++) { \
    if (vec_get(V, i) == E) { \
      index = i; \
      break; \
    } \
  } \
  index \
})

#define vec_reverse(V) { \
  for (int i = 0, j = vec_len(V) - 1; i < j; i++, j--) { \
    vec_get(V, vec_len(V)) = vec_get(V, i); \
    vec_get(V, i) = vec_get(V, j); \
    vec_get(V, j) = vec_get(V, vec_len(V)); \
  } \
}


#define VEC_FREE_2(V, F) { \
  (V).free = LAMBDA(void, F); \
  VEC_FREE_1(V); \
}
#define VEC_FREE_1(V) { \
  if ((V).free != NULL) { \
    for (int i = 0; i < vec_len(V); i++) { \
      (V).free(vec_get(V, i)); \
    } \
  } \
  free((V).data); \
}
#define vec_free(...) VFUNC(VEC_FREE_, __VA_ARGS__)

#define vec_foreach(V, FN) ({ \
  for (int i = 0; i < vec_len(V); i++) { \
    LAMBDA(void, FN)(vec_get(V, i), i); \
  } \
})

#define vec_realloc(V) \
  if ((V).len >= (V).cap) { \
    (V).cap = ceil((V).cap * VEC_RESIZE_RATIO); \
    (V).data = realloc((V).data, (V).cap * sizeof (*(V).data)); \
  }

#define vec_resize(V, S) \
  (V).len = S; \
  vec_realloc(V);

#define vec_map(V, FN) ({ \
  for (int i = 0; i < vec_len(V); i++) { \
    vec_get(V, i) = LAMBDA(vec_type(V), FN)(vec_get(V, i), i); \
  } \
})

#define FORMAT_TYPE(T, V) T: "%"#V, const T: "%"#V

#define GET_FORMAT(X) _Generic((X), \
  FORMAT_TYPE (int,                 d),   \
  FORMAT_TYPE (long int,            l),   \
  FORMAT_TYPE (long long int,       l),  \
  FORMAT_TYPE (unsigned int,        u),   \
  FORMAT_TYPE (unsigned long int,  lu),  \
  FORMAT_TYPE (float,               f),   \
  FORMAT_TYPE (double,             lf),  \
  FORMAT_TYPE (char,                c),   \
  FORMAT_TYPE (unsigned char,       d),   \
  FORMAT_TYPE (char (*),            s),   \
  default: "")

#define vec_print(V) vec_print_(GET_FORMAT(*(V).data), sizeof *(V).data, *(vec_void_t *)&V)

static void vec_print_(const char *fmt, const size_t bytes, const vec_void_t vec) {
  putchar('{');
  for (size_t i = 0; i < vec.len; i++) {
    switch (fmt[1]) {
    case 's':
      putchar('"');
      printf(fmt, *(size_t *)(vec.data + bytes * i));
      putchar('"');
      break;
    case 'c':
      putchar('\'');
      printf(fmt, *(size_t *)(vec.data + bytes * i));
      putchar('\'');
      break;
    default:
      printf(fmt, *(size_t *)(vec.data + bytes * i));
    }
    if (i + 1 != vec.len) {
      printf(", ");
    }
  }
  puts("}");
}
