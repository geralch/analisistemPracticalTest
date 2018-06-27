require 'active_support/all'
require 'csv' 
require 'date'
load 'poll.rb'

# polls for a year ago
@all_polls = []
# polls per trimester
@polls_per_trime = []
# number total of polls 
@number_polls = 0

# Creates a csv file with the data given in the parameter
# polls : array of questions for every poll
def createFile(polls)
    CSV.open("LUTO_generated_information.csv","w") do |csv|
        csv << ["number","code","date","value"]
        polls.each {|poll_data| csv << poll_data }
    end     
end

# Return a random date between a start_date and end_date
# start_date : start date of the interval
# end_date : end date of the interval
# return : random date between interval
def setRandomDate(start_date,end_date)
    return Time.at((end_date.to_time.to_f - start_date.to_time.to_f)*rand + start_date.to_time.to_f)
end

# Set the array of polls generate for a trimester, set the number of polls that is going
# to generate randomly, and create that n numbers of polls getting a random date, organizing 
# the array that represents a question and push all the poll info into the global array of
# polls.
# trimester : array with the start and end date of the trimester
def createPolls(trimester)
    trimester_polls = []
    trimester_polls_number = 100 + rand(0..100)
    for i in 1..trimester_polls_number
        poll_date = Date.parse(setRandomDate(trimester[0],trimester[1]).to_s).strftime("%d/%m/%Y")
        single_poll = []
        poll = Poll.new
        questions = poll.getQuestions
        questions.each_with_index do |question, index| 
            single_poll.push([i+@number_polls,index+1,poll_date,question])
        end
        trimester_polls.push(single_poll)
    end
    @number_polls = @number_polls + trimester_polls.length
    @polls_per_trime.push(trimester_polls.length)
    trimester_polls.each {|poll| poll.each {|question| @all_polls.push(question) }}
end

# Begin the configuration of the program, set the start and end dates of
# the 4 trimesters before the actual day and begin to create the polls 
# for that trimester, saves them in a .csv file and show the general 
# information of the polls.
def beginConfiguration()
    today = Date.today
    trimester_dates = {}
    trimester_dates['trimesterOne'] = [today - 12.months, (today - 9.months) - 1.day]
    trimester_dates['trimesterTwo'] = [today - 9.months, (today - 6.months) - 1.day]
    trimester_dates['trimesterThree'] = [today - 6.months, (today - 3.months) - 1.day]
    trimester_dates['trimesterFour'] = [today - 3.months, today]

    createPolls(trimester_dates['trimesterOne'])
    createPolls(trimester_dates['trimesterTwo'])
    createPolls(trimester_dates['trimesterThree'])
    createPolls(trimester_dates['trimesterFour'])

    createFile(@all_polls)

    puts "Trimestres de un año atras a Validar ------------------"
    puts "1) #{trimester_dates['trimesterOne'][0]} a #{trimester_dates['trimesterOne'][1]} | Numero de encuestas: #{@polls_per_trime[0]}"
    puts "2) #{trimester_dates['trimesterTwo'][0]} a #{trimester_dates['trimesterTwo'][1]} | Numero de encuestas: #{@polls_per_trime[1]}"
    puts "3) #{trimester_dates['trimesterThree'][0]} a #{trimester_dates['trimesterThree'][1]} | Numero de encuestas: #{@polls_per_trime[2]}"
    puts "4) #{trimester_dates['trimesterFour'][0]} a #{trimester_dates['trimesterFour'][1]} | Numero de encuestas: #{@polls_per_trime[3]}"
    puts "======================================================="
end

# Start the program 
def startProgram()
    puts "======================================================="
    puts "============ Generador de Informacion LUTO ============"
    puts "======================================================="

    beginConfiguration
end

startProgram

