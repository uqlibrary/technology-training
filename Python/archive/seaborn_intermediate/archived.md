## Regressions

***seaborn does not ([and will not](https://stackoverflow.com/a/22852265), from the dev) produce the numerical results (coefficients, R^2, etc.) from the regression models. The models are therefore purely qualitative, with no info about them, and practically useless for most rigorous statistical analysis.***

There are two plotting functions which will allow us to produce a regression easily in seaborn: `sns.lmplot` and `sns.regplot`. As you might expect, one is figure-level and one is axes-level. For consistency (and functionality), this session uses `sns.lmplot`, but the other functions similarly.

Let's start by taking the same data and producing a linear regression.

```python
#%%
sns.lmplot(data = tips,
           x = "total_bill",
           y = "tip")
```

![image](https://user-images.githubusercontent.com/118239146/222052904-70438175-4038-4572-95eb-28815f81d87b.png)

Here, `sns.lmplot` has automatically produced a scatter plot with a linear regression, including a confidence interval. Clearly much of our data is falling outside the confidence interval, so its not necessarily the best model.

As with the facetting examples, we can use `hue`, `col` and `row` to include additional variables. For example,

```python
#%%
sns.lmplot(data = tips,
           x = "total_bill",
           y = "tip",
           hue = "smoker",
           col = "day",
           row = "time")
```

assigns the `hue` parameter (colour) to the variable **smoker**, and facets according to `col = "day"` and `row = "time"`.

![image](https://user-images.githubusercontent.com/118239146/222053794-5c71b8b3-96a0-455e-acdc-70ad96533210.png)

*Unlike* our facetting examples, however, these all include a linear regression. By applying a regresion to facetted results, we may observe relationships which are otherwise hidden in the large sample. That being said, facetting has drawbacks, as it can also hide broader group trends. Depending on your data, both or either may be relevant.

The function `sns.lmplot` would be pretty limited if it only offered linear regressions. Luckily, there are a few different methods available. To change method requires including `<method_name> = True` as an attribute in the plotting function, like `hue = ` and `data = `. The possibilities are,

| Method                | Attribute             | Notes |
| ------                | ----                  | ----- |
| Linear                | N/A (default or all `False`) | Standard linear regression. | 
| Polynomial            | `order = <int>`       | Polynomial regression with specified order, e.g. `order = 3` is a third order polynomial fit. | 
| Logistic              | `logistic = True`     | For binary variable $y$. Computer intensive, so reduce `n_boot` or `ci` if too slow. |
| Lowess                | `lowess = True`       | **Lo**cally **we**ighted **s**catterplot **s**moothing. No confidence intervals (in seaborn). |
| Log-linear            | `logx = True`         | Linear regression of the form $y \sim \log(x)$, but still displays on the $x-y$ axes. Could highlight an exponential relationship. |

> For the logistic and lowess models, seaborn uses `statsmodels`, a python statistics module, behind the scenes.

Let's produce a polynomial regression of order 3.

```python
#%%
sns.lmplot(data = tips,
           x = "total_bill",
           y = "tip",
           order = 3)
```

![image](https://user-images.githubusercontent.com/118239146/222330468-33829909-d58c-463c-83c6-6416a514ec52.png)

Alternatively, we could try the lowess model.

```python
#%%
sns.lmplot(data = tips,
           x = "total_bill",
           y = "tip",
           lowess = True)
```
> Note that if you try to use `order = ` and another model in the same plot, e.g. `logistic = True`, it will return an error, as order is only for polynomial regressions.

![image](https://user-images.githubusercontent.com/118239146/222330559-686daf0b-afd0-44a7-a018-6a13515b2b47.png)

This summarises the function `sns.lmplot`, providing some of the most common regression models. If you wanted to use a different model, a statistics package would need to be imported and used for the model. You could still then plot those results with seaborn, if you wanted to maintain visual consistancy.

### Residual plot

In the same family as the above is the residual plot, which is a scatterplot of the *residuals* from a linear regression performed in the background. If you're unfamiliar with residuals, they are a way of determining how well a regression fits, and where that fit is best.

To produce a residual plot, we use the function `sns.residplot`. Let's use it on our previous data.

```python
#%%
sns.residplot(data = tips,
              x = "total_bill",
              y = "tip")
```

![image](https://user-images.githubusercontent.com/118239146/222331779-c451bda3-dd57-48bc-8131-75cb7bcea091.png)
