require 'ostruct'

class EventsMunger

  def execute(site)
    sorted_talks = site.talks.values.sort{|l,r| l.effective_date <=> r.effective_date}
    site.upcoming_talks = sorted_talks
    site.events = site.upcoming_talks.collect{|e|
      puts "EVENT #{e.inspect} #{e.nil?} #{e.posted}"
      if ( e.posted )
        def e.date
          posted
        end
        if ( ! e.posted.respond_to?( :xmlschema ) )
          the_date = e.posted
          def the_date.xmlschema
            strftime("%Y-%m-%dT%H:%M:%S%Z")
          end
        end
        def e.content 
         "#{presentor} will present '#{title}' at #{event} in #{location} on #{effective_date}"
        end
        e
      else
        puts "posted? reject"
        nil
      end
    }#.reject!{|e| e.nil?}
    site.events.each do |e|
      puts "e.nil? #{e.nil?} #{e.inspect}"
    end
    puts site.events.inspect
  end

end
