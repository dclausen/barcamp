class ScheduleController < ApplicationController
  # caches_action :index

  def index
    @rooms    = Room.all
    @sponsors = Sponsor.all
    @talks = Talk.talks_for_logical_day
    @morning_talks = @talks.select { |t| t.start_time.hour < 12 }
    @afternoon_talks = @talks.select { |t| t.start_time.hour >= 12 }

    @sponsors_by_level = @sponsors.group_by { |sponsor| sponsor.level }

    respond_to do |format|
      format.html   {}
      format.rss    {}
      format.txt    {}
      format.iphone {}
    end
  end
  
end
