require 'netflix.rb'

describe 'netflix' do
  describe 'show' do
    #в метод show можно передать фильтры, например netflix.show(genre: 'Comedy', period: :classic) 
    #— выберет только классические комедии;
    it 'allows to get filters' do
      
    end
  end
  describe 'pay' do
    #в объект можно положить денег (например netflix.pay(25); 
    #при каждом вызове show снимается разное количество денег 
    #(1, 1.5, 3, 5 долларов в зависимости от типа фильма, описанного выше); 
    #когда денег не хватает на то чтобы посмотреть фильм — прилетает исключение;
    it 'allows to pay for movie' do
    end
  end
  describe 'how_much?' do
    #можно спросить, сколько стоит нужное кино: netflix.how_much?('The Terminator');
    it 'allows to retrive info about price of movie' do
    end
  end
end

