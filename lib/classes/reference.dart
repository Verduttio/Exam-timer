class PrimitiveWrapper {
  var value;
  PrimitiveWrapper(this.value);
}

void change(PrimitiveWrapper data, var variable) {
  data.value = variable;
}