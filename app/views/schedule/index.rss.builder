xml.instruct! :xml, :version => "1.0"
xml.rss :version => "2.0" do

  xml.channel do
    xml.title PAGE_TITLE
    xml.link  HOMEPAGE
    xml.description "Talks Schedule for #{PAGE_TITLE}"

    @talks.each do |talk|
      xml.item do
        xml.title       "#{talk.room.name} - #{talk_time(talk)} - #{talk.name}"
        xml.date        "#{talk.day.strftime("%m/%d/%Y")}"
        xml.description talk.description
        xml.pubDate     talk.updated_at.to_s(:rfc822)
        xml.link        nil
      end
    end

    @sponsors.each do |sponsor|
      xml.item do
        xml.title       sponsor.name
        xml.description sponsor.name
        xml.pubDate     sponsor.updated_at.to_s(:rfc822)
        xml.link        sponsor.homepage
      end
    end

  end
end
