


class BaseModel<T> {
  Status status;
  T data;
  String message;

  BaseModel.loading(this.message) : status = Status.LOADING;
  BaseModel.completed(this.data) : status = Status.COMPLETED;
  BaseModel .error(this.message) : status = Status.ERROR;

  @override
  String toString() {
    return "Status : $status \n Message : $message \n Data : $data";
  }
}

enum Status { LOADING, COMPLETED, ERROR }