class Identity {
  int? assertive;
  int? turbulent;

  Identity({this.assertive, this.turbulent});

  factory Identity.fromJson(Map<String, dynamic> json) => Identity(
        assertive: json['Assertive'] as int?,
        turbulent: json['Turbulent'] as int?,
      );

  Map<String, dynamic> toJson() => {
        'Assertive': assertive,
        'Turbulent': turbulent,
      };
}
