enum CardType {
    New,
    Learn,
    Review,
    Relearn,
}

enum CardQueue {
    New,
    /// due is a unix timestamp
    Learn,
    /// due is days since creation date
    Review,
    DayLearn,
    /// due is a unix timestamp.
    /// preview cards only placed here when failed.
    PreviewRepeat,
    /// cards are not due in these states
    Suspended,
    UserBuried,
    SchedBuried,
}