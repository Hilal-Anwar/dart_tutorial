void heapsPermutation(var arr, int size) {
  if (size == 1) {
    print(arr);
  } else {
    for (int i = 0; i < size; i++) {
      heapsPermutation(arr, size - 1);
      int temp;
      if (size % 2 != 0) {
        temp = arr[0];
        arr[0] = arr[size - 1];
      } else {
        temp = arr[i];
        arr[i] = arr[size - 1];
      }
      arr[size - 1] = temp;
    }
  }
}

void main() {
  heapsPermutation([5, 9, 3], 3);
}
