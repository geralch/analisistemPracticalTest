# Class that represent a single poll with only the answer of the questions
class Poll
    # answers 
    @@questions = []

    # Initialize a poll and set the answers
    def initialize()
        setAnswers
    end

    # Return the answers of the poll
    # return: question anwser for a poll
    def getQuestions()
        @@questions
    end

    # Check if a condition is fullfilled and call a clause, else 
    # assign the value on 'answer_two' to the element with index'question_two' 
    # on the questions array
    # condition : condition to fullfill
    # question_two : index of the question to assing value
    # answer_two : value to set 
    # then_clause : clause to call when the condition is fullfilled
    def checkNumber(condition,question_two,answer_two,then_clause)
        if condition
            then_clause.call
        else
            @@questions[question_two] = answer_two
        end
    end

    # Set the answers for the poll
    def setAnswers()
        # random number for question 1 between 1 and 5
        @@questions[0] = rand(1..5) 
        # random number for question 2 between 0 and 100
        @@questions[1] = rand(0..100)
        # random number for question 3 between 0 and the value in question 2 if question 2 is
        # bigger than 0 else 0
        checkNumber @@questions[1] > 0, 2, 0, -> { @@questions[2] = rand(0..@@questions[1])}
        # if answer 2 is 0, question 4 is 0, else, if question 3 is 0, question 4 is a random
        # number between 0 and the value in question 2, if question 3 is equal to question 2,
        # question 4 is 0, instead, question 4 is a random number between 0 and the diference
        # between question 2 and question 3
        checkNumber @@questions[1] > 0, 3, 0,
            -> { checkNumber @@questions[2] > 0, 3, rand(0..@@questions[1]),
                ->{ checkNumber @@questions[1] == @@questions[2], 3, rand(0..@@questions[1] - @@questions[2]),
                    ->{ @@questions[3] = 0 } } }
        # random number for question 5 between 1 and 5
        @@questions[4] = rand(1..5)
        # random number for question 6 between 0 and 100
        @@questions[5] = rand(0..100)
        # random number for question 7 between 0 and the value in question 6 if question 6 is
        # bigger than 0 else 0
        checkNumber @@questions[5] > 0, 6, 0, ->{ @@questions[6] = rand(0..@@questions[5]) }
        # option for question 8
        options = ['SI','NO']
        # random option between 'Si' or 'NO' for question 8
        @@questions[7] = options.sample
        # random number for question 9 between 1 and 5 if question 7 is 'SI' else question 9 
        # is empty
        checkNumber @@questions[7] == 'SI', 8, nil, ->{ @@questions[8] = rand(1..5) }
    end
end