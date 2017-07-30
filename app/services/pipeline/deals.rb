require 'pipeline_deals'

module Pipeline
  class Deals
    def initialize
      PipelineDeals.configure do |config|
        config.api_key = ENV['PIPELINE_API_KEY']
      end
    end

    def by_deal_stage
      @groups ||= all_deals.group_by {|deal| deal.deal_stage }
    end

    def stage_totals
      stage_totals = []
      by_deal_stage.each_pair do |stage, deals|
        stage_totals << { stage: stage.name,
                          total: deals.inject(0) {|m, v| m += v.value_in_cents / 100.00},
                          stage_percent: stage.percent.to_i
                         }
      end
      stage_totals.sort_by! {|h| h[:stage_percent]}
    end

    def max_total
      stage_totals.map {|h| h[:total]}.max
    end

    def all_deals
      @all_deals ||=  PipelineDeals::Deal.find(:all)
    end

  end

end
