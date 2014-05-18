require "multi_json"

module Rulers
  module Model
  	class FileModel

  	  def initialize(filename)
  	  	@filename = filename

  	  	#If filename is dir/37.json, @id is 37
  	  	basename = File.split(filename)[-1]
  	  	@id = File.basename(basename, ".json").to_i
  	  	obj = File.read(filename)
  	  	@hash = MultiJson.load(obj)
  	  	@hash
  	  end

  	  def [](name)
  	  	@hash[name.to_s]
  	  end

  	  def []=(name, value)
  	  	@hash[name.to_s] = value
  	  end

  	  def self.find(id)
  	  	begin
  	  	  FileModel.new("db/quotes/#{id}.json")
  	  	rescue
  	  	  return nil
  	  	end
  	  end

      def self.find_all_by(attribute, value)
        puts "value"
        files = FileModel.all
        puts "files"
        return files.select {|f| f["#{attribute}"]  ==  value}
      end

  	  def self.all
  	  	files = Dir["db/quotes/*.json"]
  	  	files.map {|f| FileModel.new f }
  	  end

      def self.create(attrs)
        hash = {}
        hash["submitter"] = attrs["submitter"] || ""
        hash["quote"] = attrs["quote"] || ""
        hash["attribution"] = attrs["attribution"] || ""
        files = Dir["db/quotes/*.json"]
        names = files.map{|f| f.split("/")[-1]}
        highest = names.map{|b| b.to_i}.max
        puts "#{highest}"
        id = highest + 1
        File.open("db/quotes/#{id}.json", "w") do |f|
          f.write <<TEMPLATE
{
  "submitter": "#{hash["submitter"]}",
  "quote": "#{hash["quote"]}",
  "attribution": "#{hash["attribution"]}"
}
TEMPLATE
        end
        FileModel.new "db/quotes/#{id}.json"
      end

      def update(params)
        puts "hello?"
        puts @hash
        puts params
        @hash =@hash.merge(params)
        data = MultiJson.dump(@hash).to_s
        puts data
        begin
          File.open(@filename, "r+") do |f|
            f.write(data)
          end
        rescue Exception => e
          puts e
        end
        puts "hello"
        self
      end

      def self.method_missing(m, *args, &block)
        puts "method missing"
        if m =~ /^find_all_by_(.*)/
          puts "matches #{m}"
          puts "my arg = #{args[0]}"
          attribute = m.to_s.gsub("find_all_by_", "")
          puts "#{attribute}"
          self.find_all_by(attribute, args[0])
        else
          super
        end
      end

      def self.respond_to?(m)
        if m =~ /^find_all_by_(.*)/
          true
        else
          super
        end
      end

  	end
  end
end