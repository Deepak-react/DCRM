class CallCountModel {
  int? incomingCalls;
  int? outgoingCalls;
  int? missedCalls;
  int? rejectedCalls;

  CallCountModel(
      {this.incomingCalls,
      this.outgoingCalls,
      this.missedCalls,
      this.rejectedCalls});

  CallCountModel.fromJson(Map<String, dynamic> json) {
    incomingCalls = json['incoming_calls'];
    outgoingCalls = json['outgoing_calls'];
    missedCalls = json['missed_calls'];
    rejectedCalls = json['rejected_calls'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['incoming_calls'] = this.incomingCalls;
    data['outgoing_calls'] = this.outgoingCalls;
    data['missed_calls'] = this.missedCalls;
    data['rejected_calls'] = this.rejectedCalls;
    return data;
  }
}
