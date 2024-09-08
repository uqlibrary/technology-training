## Extras

Here are some extras that usually don't fit in the introductory session, but that might be useful for future sessions.

### Loops

A "for loop" will execute something for each element of a list:

```python
friends = ["Mary", "Toya", "Fernand"]
for name in friends:
	print(name + "is a perfectly fine name")
```

This will allow you to automate the boring repetitive tasks!

### Custom functions

We can create our own custom functions to reuse later on:

```python
# define the function
def my_function(arg1, arg2):
	prod = arg1 * arg2
	sum = prod + 10
	return sum
# use the custom function
my_function(3, 5)
```

We have to specify the function **name**, what **arguments** are available, what **operations** we do with them, and what the function **returns**.

### More visualisations

Executing several lines together will render everything on the same visualisation. See for example this code that plots two lines together, modifies axis ranges, adds a legend and styles axis labels with LaTex, and saves to pdf:

```python
x = np.linspace(0, 15, 8)
y = x**2
plt.plot(x, y, "bo-", label = "High")
plt.plot(x, x**1.5, "gs--", label = "Low")
# we can use LaTex
plt.xlabel("$X$")
plt.ylabel("$Y$")
plt.legend(loc = "upper left")
# save plot
plt.savefig("hi-lo.pdf")
```

To create a histogram:

```python
x = np.random.normal(size = 1000)
plt.hist(x)
plt.hist(x, bins = 20)
```

We can join several plots on the same image with the `subplot()` function, which takes three numbers: the number of rows, number of columns, and position of the subplot.

```python
x = np.random.gamma(2, 3, 100000) # create data
plt.figure() # initialise
plt.subplot(221)
plt.hist(x, bins = 30)
plt.subplot(222)
plt.hist(x, bins = 30, cumulative = True)
plt.subplot(223)
plt.hist(x, bins = 30, density = True)
plt.subplot(224)
plt.boxplot(x)
```

> You can also use `subplot()` with three separate arguments, e.g. `subplot(3, 3, 7)`