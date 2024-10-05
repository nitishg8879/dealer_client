class PaymentVerifyModel {
  String? id;
  String? entity;
  int? amount;
  String? currency;
  String? status;
  dynamic orderId;
  dynamic invoiceId;
  bool? international;
  String? method;
  int? amountRefunded;
  dynamic refundStatus;
  bool? captured;
  String? description;
  dynamic cardId;
  String? bank;
  dynamic wallet;
  dynamic vpa;
  String? email;
  String? contact;
  PaymentVerifyModelNotes? notes;
  dynamic fee;
  dynamic tax;
  dynamic errorCode;
  dynamic errorDescription;
  dynamic errorSource;
  dynamic errorStep;
  dynamic errorReason;
  AcquirerData? acquirerData;
  int? createdAt;

  PaymentVerifyModel(
      {this.id,
      this.entity,
      this.amount,
      this.currency,
      this.status,
      this.orderId,
      this.invoiceId,
      this.international,
      this.method,
      this.amountRefunded,
      this.refundStatus,
      this.captured,
      this.description,
      this.cardId,
      this.bank,
      this.wallet,
      this.vpa,
      this.email,
      this.contact,
      this.notes,
      this.fee,
      this.tax,
      this.errorCode,
      this.errorDescription,
      this.errorSource,
      this.errorStep,
      this.errorReason,
      this.acquirerData,
      this.createdAt});

  PaymentVerifyModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    entity = json['entity'];
    amount = json['amount'];
    currency = json['currency'];
    status = json['status'];
    orderId = json['order_id'];
    invoiceId = json['invoice_id'];
    international = json['international'];
    method = json['method'];
    amountRefunded = json['amount_refunded'];
    refundStatus = json['refund_status'];
    captured = json['captured'];
    description = json['description'];
    cardId = json['card_id'];
    bank = json['bank'];
    wallet = json['wallet'];
    vpa = json['vpa'];
    email = json['email'];
    contact = json['contact'];
    notes = json['notes'] != null ? new PaymentVerifyModelNotes.fromJson(json['notes']) : null;
    fee = json['fee'];
    tax = json['tax'];
    errorCode = json['error_code'];
    errorDescription = json['error_description'];
    errorSource = json['error_source'];
    errorStep = json['error_step'];
    errorReason = json['error_reason'];
    acquirerData = json['acquirer_data'] != null
        ? new AcquirerData.fromJson(json['acquirer_data'])
        : null;
    createdAt = json['created_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['entity'] = this.entity;
    data['amount'] = this.amount;
    data['currency'] = this.currency;
    data['status'] = this.status;
    data['order_id'] = this.orderId;
    data['invoice_id'] = this.invoiceId;
    data['international'] = this.international;
    data['method'] = this.method;
    data['amount_refunded'] = this.amountRefunded;
    data['refund_status'] = this.refundStatus;
    data['captured'] = this.captured;
    data['description'] = this.description;
    data['card_id'] = this.cardId;
    data['bank'] = this.bank;
    data['wallet'] = this.wallet;
    data['vpa'] = this.vpa;
    data['email'] = this.email;
    data['contact'] = this.contact;
    if (this.notes != null) {
      data['notes'] = this.notes!.toJson();
    }
    data['fee'] = this.fee;
    data['tax'] = this.tax;
    data['error_code'] = this.errorCode;
    data['error_description'] = this.errorDescription;
    data['error_source'] = this.errorSource;
    data['error_step'] = this.errorStep;
    data['error_reason'] = this.errorReason;
    if (this.acquirerData != null) {
      data['acquirer_data'] = this.acquirerData!.toJson();
    }
    data['created_at'] = this.createdAt;
    return data;
  }
}

class PaymentVerifyModelNotes {
  String? productId;
  String? fullName;
  String? userID;

  PaymentVerifyModelNotes({this.productId, this.fullName, this.userID});

  PaymentVerifyModelNotes.fromJson(Map<String, dynamic> json) {
    productId = json['productId'];
    fullName = json['fullName'];
    userID = json['userID'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['productId'] = this.productId;
    data['fullName'] = this.fullName;
    data['userID'] = this.userID;
    return data;
  }
}

class AcquirerData {
  String? bankTransactionId;

  AcquirerData({this.bankTransactionId});

  AcquirerData.fromJson(Map<String, dynamic> json) {
    bankTransactionId = json['bank_transaction_id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['bank_transaction_id'] = this.bankTransactionId;
    return data;
  }
}
