# Archive

Here lie extracts from the revamp that didn't make the final cut.

## Fundamentals

### Activities

These just seemed too hard.

#### Activity 1 (Rounder)

In this first activity, your challenge is to produce code which takes a user input, rounds it to the number of digits they specify, and returns the rounded result. In addition to the `round` function, use the `input` function to get user inputs. For example, the following code asks for the user's first name and outputs the first letter:

```python
name = input("Please input your name")
first_letter = name[0]
print(f"The first letter of your name is {first_letter})
```

You'll also need to use `float( ... )` and `int( ... )` around the inputs to change them from numbers to strings.

In sum,
- Use `print( ... )` to present a welcome message to the user
- Use `float(input( ... ))` to ask the user for a number to round
- Use `int(input( ... ))` to ask the user for the number of digits to round
- Use `round( ... )` to round their number
- Use `print( ... )` to output the rounded answer


<details>
  <summary>Solution</summary>
  
  We have five lines of code corresponding to the five steps above:
  
  ```python
  # Rounder
    
  # Welcome message
  print("Welcome to the rounder. Here you can input a number and round it.")

  # Collect number to round and number of digits
  number = float(input("What is your number? "))
  precision = int(input("How many digits would you like to round it to? "))

  # Round number and print result
  rounded = round(number, precision)
  print(f"Your number is {rounded}")
  ```
              
</details>

#### Activity 2 (Number Guesser)

For the second activity, we're going to create a number guessing game. We'll use the `input` command again and incorporate the new `while`, `if` and `else` functions. The game is simple: the code will pick a random number, and you need to guess it. After each guess, the game tells you if the guess was too high or too low. 

We'll need to use some new code:

```python
import random
random.randint(5,10)
```

This brings in some extra code (`import random`), and picks a random number between 5 and 10. We'll look at packages in the next section, these are the only lines you'll need.

The coding steps for this activity are:

- Import the random package `import random`.
- Pick a random number using `answer = random.randint(MIN, MAX)`.
- Ask the user for their guess using `int(input( ... ))`.
- Use a `while` loop to check whether their guess matches the answer.
- Use `if` and `else` statements inside the loop to respond "Too high" or "Too low".
- Continue to ask for the user's guess.
- Print a congratulatory message after they are correct.

<details>
  <summary>Solution</summary>
  
  We have five lines of code corresponding to the five steps above:
  
  ```python
  # Number guesser

  # Bring in some extra code
  import random

  # Define the max and min for the answer
  MIN = 0
  MAX = 100

  # Pick a random number for the answer
  number = random.randint(MIN, MAX)

  # Ask the user for an initial guess
  guess = int(input("What is your guess? "))
  count = 1

  # If incorrect, keep asking
  while guess != number:
    
      # Print messages to help user
      if guess > number:
          print("Too high.")
        
      else:
          print("Too low.")
    
      # Ask for new guess
      guess = int(input("What is your guess? "))
      count += 1
    
  # Congratulatory message
  print(f"Correct! The answer is {number}. It took you {count} guesses.")
  ```
              
</details>
## Data Transformation

## Visualisation

## Notebooks and Advanced Visualisation

## Statistics
