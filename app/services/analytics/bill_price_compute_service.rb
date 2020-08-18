module Analytics
  class BillPriceComputeService
    attr_reader :result

    def initialize(start_date, end_date)
      @start_date = start_date
      @end_date = end_date
    end

    def execute
      bills_by_date = Bill.where(created_at: [start_date..end_date]).includes(detail_bills: :vaccine).group_by(&:created_at)

      result = {}

      bills_by_date.each do |date, bills|
        result[date.strftime("%Y-%m-%d")] = bills.present? ? bills.map(&:detail_bills).flatten.map(&:vaccine).sum(&:saleprice) : 0
      end

      puts result


      nil
    end

    private

    attr_reader :start_date, :end_date
  end
end
