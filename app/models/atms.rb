class Atms
  @@TRANSACTION_TYPES = %w( 
    w4.cash
    w4.system
    w4.internal.transfer
    w4.external.payment
    w4.noncash
    w4.internal.transfer.cash.out
    w4.internal.transfer.cash.in
    w4.external.payment.cash
    w4.currency.exchange.cash
    )
  @@ACCOUNT_TYPES = %w(
    TR
    ZR
    DAS
    DOS
    SAS
    SOS
    CI
    CO
  )
  def intialize
  end

  def self.account_types
    @@ACCOUNT_TYPES
  end
  
  def self.transaction_types
    @@TRANSACTION_TYPES
  end
end
