require 'pry'

class Transaction
  def initialize(invoice)
    @invoice = invoice
  end

  def statement
    @total_amount = 0
    @volume_credits = 0
    @result = "Statement for #{@invoice[:customer]}\n"

    @invoice[:performances].each do |perf|
      play = plays[perf[:play_ID].to_sym]
      this_amount = 0

      case play[:type]
      when 'tragedy'
        this_amount = 40_000;
        if perf[:audience] > 30
          this_amount += 1_000 * (perf[:audience] - 30)
        end
      when 'comedy'
        this_amount = 30_000;
        if perf[:audience] > 20
          this_amount += 10_000 + 500 * (perf[:audience] - 20)
          this_amount += 300 * perf[:audience]
        end
      else
        raise 'Play Type not found!'
      end

      # add volume credits
      @volume_credits += [(perf[:audience] - 30), 0].max
      # add extra credit for every ten comedy attendees
      @volume_credits += (perf[:audience] / 10).floor if play[:type] == 'comedy'

      # print line for this order
      @result += "#{play[:name]}: $#{'%.2f' % (this_amount / 100.0)} (#{perf[:audience]} seats)\n"
      @total_amount += this_amount
    end

    @result += "Amount owed is $#{'%.2f' % (@total_amount / 100.0)}\n"
    @result += "You earned #{@volume_credits} credits"

    @result
  end

  private

  def plays
    {
      'hamlet': { 'name': 'Hamlet', 'type': 'tragedy' },
      'aslike': { 'name': 'As You Like It', 'type': 'comedy' },
      'othello': { 'name': 'Othello', 'type': 'tragedy' }
    }
  end
end
