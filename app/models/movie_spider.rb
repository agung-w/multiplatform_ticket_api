class MovieSpider < Kimurai::Base
    @name = 'movie_spider'
    @engine = :mechanize

    @config = {
      user_agent: "Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/68.0.3440.84 Safari/537.36",
      disable_images: true,
      # before_request: { delay: 4..7 }
    }
    def self.process(url)
      @start_urls = [url]
      self.crawl!
    end
  
    # def parse(response, url:, data: {})
    #   count=0
    #   response.xpath("//li[@class='glide__slide']").each do |movie|
    #     item = {}
    #     current_item=movie.xpath("//li[@class='glide__slide']//p/a")[count]&.text&.squish
    #     unless current_item.blank? || current_item.nil?
    #       uri = URI("https://api.themoviedb.org/3/search/movie?api_key=a750a1b20a0e229287dc030aa3700e95&language=en-US&query=#{current_item}&page=1&include_adult=false")
    #       http = Net::HTTP.get(uri, {'Content-Type' => 'application/json'})
    #       movie=JSON.parse(http)
    #       item [:title]=movie["results"][0]['title']
    #       item [:poster_url]=movie["results"][0]['poster_path']
    #       Movie.where(item).first_or_create
    #     end
    #     count+=1
        
    #   end
    # end
    def parse(response, url:, data: {})
      count=0
      item = {}
      response.xpath("//div[@class='item movie']").each do |movie|
        current_item= movie.xpath("//h2/a")[count]&.text
        unless current_item.blank? || current_item.nil?
          uri = URI("https://api.themoviedb.org/3/search/movie?api_key=a750a1b20a0e229287dc030aa3700e95&language=en-US&query=#{current_item}&page=1&include_adult=false")
          http = Net::HTTP.get(uri, {'Content-Type' => 'application/json'})
          movie=JSON.parse(http)
          item [:title]=movie["results"][0]['title']
          item [:poster_url]=movie["results"][0]['poster_path']
          item [:tmdb_id]=movie["results"][0]['id']
          item [:vote_average]=movie["results"][0]['vote_average']
          item [:airing_status]="airing"
          Movie.where(item).first_or_create
        end
        count+=1
      end
      if next_page=response.at_xpath("//div[@class='paggingcont']//li//a[@title='Selanjutnya']")
        request_to :parse, url: absolute_url(next_page[:href], base: url)
      end  
    end

    # def parse_repo_page(response)
    #   item = {}b 
    #   puts response.xpath("//ul[@class='item movie//h2/a")[count]&.text&.squish
    # end
  end