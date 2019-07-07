require 'net/http'

threads = []
1.upto(2gt) do |i|
  threads << Thread.start do
    p "Starting Thread #{i} - #{Thread.current.object_id}"
    res = Net::HTTP.get(URI('http://localhost:9999/lazy'))
    p "#{i} - #{res}"
  end
end
  
threads.each { |t| t.join }
