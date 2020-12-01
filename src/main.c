#include <stdio.h>
#include <string.h>
#include <stdlib.h>
#include <limits.h>

#define MAX_ELEMENTS_IN_ARRAY 100
#define error(...) (fprintf(stderr, __VA_ARGS__))

int read_array(int *array, size_t *array_size)
{
    char div = ' ';
    size_t element_count = 0;
    while (div == ' ') {
        if(scanf("%d%c", &array[element_count++], &div) < 2) {
            error("Cannot read element");
            return -32767;
        }
    }
    *array_size = element_count;
    return 0;
}

int set_parameters_values(int argv, char **argc, int *from, int *to)
{
    if (argv < 2) {
        return -1;
    }
    if (argv > 3) {
        return -2;
    }
    int from_amount = 0;
    int to_amount = 0;
    for (int i = 1; i < argv; i++) {
        if (strncmp(argc[i], "--from=", 7) == 0) {
            from_amount++;
            *from = (int)strtoll(argc[i] + 7, NULL, 10);
        }
        if (strncmp(argc[i], "--to=", 5) == 0) {
            to_amount++;
            *to = (int)strtoll(argc[i] + 5, NULL, 10);
        }
    }
    if (from_amount > 1 || to_amount > 1) {
        return -3;
    }
    if (from_amount == 0 && to_amount == 0) {
        return -4;
    }
    return 0;
}

size_t count_swap(int const *first_array, int const *second_array, size_t arrays_size)
{
    size_t swap_count = 0;
    for (size_t i = 0; i < arrays_size; ++i) {
        if (first_array[i] != second_array[i]) {
            swap_count++;
        }
    }
    return swap_count;
}

int create_new_array(int const *array, size_t array_size, int *new_array, size_t *new_size, int from, int to)
{
    size_t new_element_count = 0;
    for (size_t i = 0; i < array_size; ++i) {
        if (array[i] > from && array[i] < to) {
            new_array[new_element_count++] = array[i];
        } else if (array[i] <= from) {
            if (fprintf(stdout, "%d ", array[i]) < 0) {
                error("Cannot write to stdout");
                return -32767;
            }
            if (array[i] >= to) {
                if (fprintf(stderr, "%d ", array[i]) < 0) {
                    error("Cannot write to stderr");
                    return -32767;
                }
            }
        } else if (array[i] >= to) {
            if (fprintf(stderr, "%d ", array[i]) < 0) {
                error("Cannot write to stderr");
                return -32767;
            }
            if (array[i] <= from) {
                if (fprintf(stdout, "%d ", array[i]) < 0) {
                    error("Cannot write to stdout");
                    return -32767;
                }
            }
        }
    }
    *new_size = new_element_count;
    return 0;
}

void copy_array(int *dest, int const *src, size_t array_size)
{
    for (size_t i = 0; i < array_size; ++i) {
        dest[i] = src[i];
    }
}

void sort_array(int *array, int array_size);

void swap (int *a, int *b);

int main (int argv, char *argc[])
{
    int from = INT_MIN;
    int to = INT_MAX;
    int errortype = set_parameters_values(argv, argc, &from, &to);
    if (errortype != 0)
    {
        return errortype;
    }
    size_t array_size = 0;
    int *array = (int *)malloc(MAX_ELEMENTS_IN_ARRAY * sizeof(int));
    if (array == NULL) {
        error("Cannot allocate array");
        return -32767;
    }
    int reading_result = read_array(array, &array_size);
    if (reading_result != 0) {
        return reading_result;
    }
    size_t new_array_size = 0;
    int *new_array = (int *)malloc(MAX_ELEMENTS_IN_ARRAY * sizeof(int));
    if (new_array == NULL) {
        error("Cannot allocate new array");
        return -32767;
    }
    int creating_status = create_new_array(array, array_size, new_array, &new_array_size, from, to);
    if (creating_status != 0) {
        return creating_status;
    }
    int *new_array_2 = (int *)malloc(new_array_size * sizeof(int));
    if (new_array_2 == NULL) {
        error("Cannot allocate new array(second)");
        return -32767;
    }
    copy_array(new_array_2, new_array, new_array_size);
    sort_array(new_array, new_array_size);
    int swap_count = count_swap(new_array, new_array_2, new_array_size);
    free(array);
    free(new_array);
    free(new_array_2);
    return swap_count;
}