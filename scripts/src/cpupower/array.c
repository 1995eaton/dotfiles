#include <stdio.h>
#include <string.h>
#include <stdlib.h>

typedef struct Array {
  array_t *data;
  size_t capacity;
  size_t length;
} Array;

Array create_array() {
  Array arr;
  arr.capacity = 8;
  arr.length = 0;
  arr.data = (array_t*) malloc(sizeof(array_t) * arr.capacity);
  return arr;
}

void array_resize(Array *arr, size_t size) {
  arr->data = realloc(arr->data, sizeof(array_t) * size);
  arr->capacity = size;
}

void array_push(Array *arr, array_t item) {
  arr->data[arr->length++] = item;
  if (arr->length >= arr->capacity) {
    array_resize(arr, arr->capacity * 2);
  }
}

const array_t array_pop(Array *arr) {
  if (arr->length > 0) {
    return arr->data[--(arr->length)];
  }
  return NULL;
}

const array_t array_popn(Array *arr, int index) {
  if (index < 0 || index >= arr->length) {
    return NULL;
  }
  array_t item = arr->data[index];
  arr->length--;
  memmove(arr->data + index, arr->data + index + 1,
      sizeof(array_t) * (arr->length - index));
  return item;
}

const array_t array_get(Array *arr, int index) {
  return arr->data[index];
}

void array_reverse(Array *arr) {
  array_t *start = arr->data;
  array_t *end = arr->data + arr->length - 1;
  while (start < end) {
    array_t temp = *start;
    *start++ = *end;
    *end-- = temp;
  }
}

int array_indexof(Array *arr, array_t item) {
  for (size_t i = 0; i < arr->length; i++) {
    if (memcmp(&arr->data[i], &item, sizeof(array_t)) == 0) {
      return i;
    }
  }
  return -1;
}

void clear_array(Array *arr) {
  for (size_t i = 0; i < arr->length; i++) {
    free(arr->data[i]);
  }
  free(arr->data);
  arr->data = calloc(8, sizeof(array_t));
  arr->capacity = 8;
  arr->length = 0;
}
