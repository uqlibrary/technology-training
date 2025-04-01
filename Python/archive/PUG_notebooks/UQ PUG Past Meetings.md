# UQ PUG Past Meetings

# 2024 May 2<sup>nd</sup> -- UQ PUG 8

Welcome to UQ Python User Group! Check out our general info above for how we work and what we do. Below you'll find the details of this month's gathering, and below that last month's.


## Overview

### Structure

1. We start today by adding our names to the table below
1. Add your questions to this page
1. This month's presentation
1. Finally, we spend the rest of the session answering the questions you've brought!

### Mailing list

If you would like to be on the mailing list and receive the latest PUG updates, please sign up here:

https://forms.office.com/r/6qvfFX0qGr

Feel free to send this link to anyone you think may benefit.

### Training Resources

We offer Python training sessions and resources, you can find our introductory guide [here](https://github.com/uqlibrary/technology-training/blob/master/Python/python_intro/python_intro.md).


## Introduce yourself
| What's your name? | Where are you from? | Why are you here? |
| --- | --- | --- |
| Julia | UQ HABS | Learn & meet python users |
| Cameron | UQ Library / SMP | Help and learn! |
| | | |
| | | |
| | | |
| | | |
| | | |
| | | |
| | | |
| | | |
| | | |
| | | |
| | | |
| | | |
| | | |
| | | |

# 2024-5-11: UQ PUG 7

Welcome to UQ Python User Group! Check out our [general information](https://app.noteable.io/f/c84cf34f-03eb-48eb-aff4-ccf80b013b5c/UQ-PUG-General-Info.ipynb?cellID=1e2cf356) for details about who we are and what we do.

This month we discussed a basic introduction to Web Scraping using `requests` and `BeautifulSoup`.

## Overview

### Structure

1. We start today by adding our names to the table below
1. Add your questions to this page
1. This month's presentation
1. Finally, we spend the rest of the session answering the questions you've brought!

### Mailing list

If you would like to be on the mailing list and receive the latest PUG updates, please sign up here:

https://forms.office.com/r/6qvfFX0qGr

Feel free to send this link to anyone you think may benefit.

### Training Resources

We offer Python training sessions and resources, you can find our introductory guide [here](https://github.com/uqlibrary/technology-training/blob/master/Python/python_intro/python_intro.md).


## Introduce yourself
| What's your name? | Where are you from? | Why are you here? |
| --- | --- | --- |
| Cameron West | UQ Library / SMP | To help, share and learn |
|Nicholas Wiggins |UQ Library |To help and Learn |
|Theophilus Mensah|QAAFI |To learn and share |
| | | |
|David Chau |QAAFI |For Fun |
| | | |
| Julia Wood | UQ HABS | to learn and meet other python users|
|Thu Luong Le |ComArts School | To learn about web scraping|
| | | |
|Tommy Nguyen |UQ ADP |To Learn about Web Scraping + meet others |
| | | |
|Ryan Leung |SOE | Learn python|
|Lydeth |Business school |I do have to pass my CSSE7030 course which is centered around Python and get myself closer to Python? |
| Jay|UQ EAIT|Learn python and have some inspiration |
| | | |

# 2024-3-7: UQ PUG 6

Welcome to UQ Python User Group! Check out our [general information](https://app.noteable.io/f/c84cf34f-03eb-48eb-aff4-ccf80b013b5c/UQ-PUG-General-Info.ipynb?cellID=1e2cf356) for details about who we are and what we do.

## Overview

### Structure

1. We start today by adding our names to the table below
1. Add your questions to this page
1. This month's presentation
1. Finally, we spend the rest of the session answering the questions you've brought!

### Mailing list

If you would like to be on the mailing list and receive the latest PUG updates, please sign up here:

https://forms.office.com/r/6qvfFX0qGr

Feel free to send this link to anyone you think may benefit.

### Training Resources

We offer Python training sessions and resources, you can find our introductory guide [here](https://github.com/uqlibrary/technology-training/blob/master/Python/python_intro/python_intro.md).

## Today's Presentation

Today we looked at the popular plotting package `matplotlib`. You can find [the Jupyter notebook we worked from](https://github.com/uqlibrary/technology-training/blob/0b2ea6c409c8368c86921955daa2db137b2dd650/Python/PUG_notebooks/matplotlib_demo.ipynb)  on our GitHub page.

## Introduce yourself
| What's your name? | Where are you from? | Why are you here? |
| --- | --- | --- |
|Nick Wiggins |UQ Library| Here to help (and learn!) |
| Cameron West | UQ Library / SMP| To learn and help|
| | | |
|Dennis |SMP |To learn and get help |
|Karen Fang |UQ BEL |To learn |
|Valentina|UQ Library |Here to say hello! |
|Theophilus Mensah |QAAFI |here to learn |
| Y Allo| SMP|Learn this sofware |
| Senn Oon | UQ Library | Placement student observing! |
|Jay | UQ |to learn python |
| | | |
| | | |
| | | |
| | | |
| | | |


## Questions

If you have any Python questions you'd like to explore with the group, please put your question and name in the sections below.

If you think you can help, feel free to contribute to the answers section!

### Question 1 - Tuple or List use - Nida
when to use tuple and when to use list?

```python
## when we create a table using pandas DataFrame, we can create a tuple like below:
df = pd.DataFrame(columns=("number", "name", "major"))

## or a list like below:
df = pd.DataFrame(columns=["number", "name", "major"])

## so in what occassion are we using tuple & in what occassion are we using list? Thanks so much

```

#### Answers
* When you need to ensure that the elements shouldn't change. Tuples cannot be edited (immutable), you can't change their elements, so only when this is necessary.
* They can be faster, since they are a constant size -- according to [StackOverflow](https://stackoverflow.com/questions/1708510/list-vs-tuple-when-to-use-each)
* 

### Question 2 - matplotlib - Nida
I have tried matplotlib for making a single line graph, but I still don't know how to use it for working with multiple data as follows


```python
# I have these Optical Density in 750nm data that show the growth curve for each species
OD750_data = [["Species","8 Dec 2023","15 Dec 2023", "18 Dec 2023"],
            ["Nannochloropsis", 0.2615, 1.0385, 0.822],
            ["Phaeodactylum", 0.208, 0.603, 0.499],
            ["Tisochrysis", 0.1015, 0.135, 0.1265]]
table1 = tabulate(OD750_data)
print(table1)

table2 = tabulate(OD750_data,headers='firstrow')
print(table2)

# how do I turn this table into line graphs with 3 growth curves for 3 species?
```

#### Answers
* Great question Nida. Some of the difficulty lies in the data shape, the easiest way to use data for these things is in long form. I've used a few steps below
    1. Turn it into a `pandas` dataframe
    2. Transform it into three columns and nine rows with `pd.melt` (long form). Run `print(OD750_data)` to see this
    3. Plot each line by subsetting `OD750_data["Species"] == `.
```python
import pandas as pd

# I have these Optical Density in 750nm data that show the growth curve for each species
OD750_data = [["Species",8,15, 18],
            ["Nannochloropsis", 0.2615, 1.0385, 0.822],
            ["Phaeodactylum", 0.208, 0.603, 0.499],
            ["Tisochrysis", 0.1015, 0.135, 0.1265]]

OD750_data = pd.DataFrame(columns = OD750_data[0], data = OD750_data[1:])

OD750_data = pd.melt(OD750_data, "Species", var_name = "time")

plt.plot("time", "value", data = OD750_data[OD750_data["Species"] == "Nannochloropsis"])
plt.plot("time", "value", data = OD750_data[OD750_data["Species"] == "Phaeodactylum"])
plt.plot("time", "value", data = OD750_data[OD750_data["Species"] == "Tisochrysis"])

plt.show()
```

### Question 3 - Question - Dennis
 Reserve[:,n+1] = Reserve[:,n].reshape(M,1) + (P - S).reshape(M,1)
 
 ValueError: could not broadcast input array from shape (1000,1) into shape (1000,)
 
 Comment: I am pretty sure the broadcast dimension matches. I just dont understand this ".reshape" thing.


```python
## Code for Q3
import numpy as np

#%%
def total_claim_amount(paths, lambda_parameter, mu_parameter, step_size):

    #Simulate the number of claims (N): Poisson distribution
    num_claims = np.random.poisson(lam = lambda_parameter*step_size, 
                                    size = paths)
    dime = np.max(num_claims) 
    
    #Simulate claim sizes (X): Exponential distribution
    # claim_sizes = np.random.exponential(scale = mu_parameter, 
    #                                     size = (paths, dime))
    # claim_sizes = np.random.pareto(a = mu_parameter, 
    #                                     size = (paths, dime))
    claim_sizes = np.random.weibull(a = mu_parameter, 
                                        size = (paths, dime))

    #check to create True (1) and False (0)
        #So, only the correct number of claims are counted
    check = np.arange(dime) < num_claims[:, None]

    #Calculate total claim amount for all paths
        #sum across the rows: axis = 1
        #total was a row vector: reshaped into column vector
    total = np.sum(claim_sizes * check, axis=1).reshape(paths, 1)

    #Calculate mean and standard deviation of total claim amounts
    mean_total = np.mean(total)
    std_total = np.std(total)
    
    # print("Mean total claim amount:", mean_total)
    # print("Standard deviation of total claim amount:", std_total)
    return total, mean_total, std_total

def premium(lambda_parameter, mu_parameter, step_size):
    p = lambda_parameter * mu_parameter * step_size
    return p

#%% Parameters
M = 10**3  #Number of paths
N = 360 #Number of time steps (days)
lambda_parameter = 12 #Poisson distribution parameter for claim number process
                            #1 claim month
mu_parameter = 1 #Exponential distribution parameter for claim size process
                    #mean claim size is $1

Reserve = np.zeros((M,N))
Reserve[:,0] = 100 * mu_parameter * np.ones((M,))

#Compute premium income
P = premium(lambda_parameter, mu_parameter, 1/N) * np.ones((M,1))

#%%
for n in range(N - 1):
    
    #Compute total claim amount process
    S,_,_ = total_claim_amount(M, lambda_parameter, mu_parameter, 1/N)
    
    #Compute reserve for the next time step
    Reserve[:,n+1] = Reserve[:,n].reshape(M,1) + (P - S).reshape(M,1)
```

#### Answers
* Hi Dennis, might need a few more details about what you need here, but I can tell you why the reshaping isn't working. Essentially, the [.reshape](https://numpy.org/doc/1.26/reference/generated/numpy.reshape.html#numpy.reshape) method is trying to take your **column** `Reserve[:,n]` and turn it into a **row**. It works! Run `Reserve[:,n].reshape(M,1) + (P - S).reshape(M,1)` by itself to see. The problem is that your new **row** can't be assigned to `Reserve[:,n+1]` because that is a **column** of `Reserve`. Do you need to reshape at all here?
* In context, every column in Reserve matrix is a time step (eg: t=1, t=2 etc); and every row is just a different trial (trial 1, 2, 3 ...). What I want to achieve is using the column t=n value to calculate column t=n+1 value. This is why I used a loop. And my intend to reshape is because I am making sure the dimensions of Left and Right are matching.

    This is why I am confused by the error message because I essentially have the correct dimension, but somehow I cant broadcast it correctly??? - Dennis


### Question 4 - Example of Conditionals - Nida
Add more details here


```python
## Code for Q4

```

#### Answers
```
# What are conditionals?

# 'if' statements. These are the control blocks for your code, they're logical filters.

a = 10
b = 20

print(a>b)

# Checks if a > b
if a > b:
    print("a is greater than b!")
    print("Everything that is indented will run")


    print("see!")
    
# elif statements only check if the previous statements failed! 
elif a == b:
    print("We also checked if they were the same. They are!")
    
elif a < 0:
    print("a is a negative number and less than b")

# else statements capture everything that failed. They don't have a condition
else:
    print("Everything failed. a must be greater than 0 and less than b")
    
```


# 2024-2-7: UQ PUG 5

Welcome to UQ Python User Group! Check out our [general information](https://app.noteable.io/f/c84cf34f-03eb-48eb-aff4-ccf80b013b5c/UQ-PUG-General-Info.ipynb?cellID=1e2cf356) for details about who we are and what we do.

## Structure

1. We start today by adding our names to the table below
1. Add your questions to this page
1. This month's presentation
1. Finally, we spend the rest of the session answering the questions you've brought!

## Mailing list

If you would like to be on the mailing list and receive the latest PUG updates, please sign up here:

https://forms.office.com/r/6qvfFX0qGr

Feel free to send this link to anyone you think may benefit.

## Training Resources

We offer Python training sessions and resources, you can find our introductory guide [here](https://github.com/uqlibrary/technology-training/blob/master/Python/python_intro/python_intro.md).

## Introduce yourself
| What's your name? | Where are you from? | Why are you here? |
| --- | --- | --- |
|Nida | SCMB|learning about python |
| Cameron West | UQ Library / SMP | To help with Python! |
|Sonia |Colombia/Master of Business |Improving Python Skills |
|Elizabeth |Lecturer of Finance, UQ Business School |Just to learn about Python for my research projects |
|Lily | UQ BA student| to learn how to use python handling data|
| | | |
| | | |
| | | |
| | | |
| | | |
| | | |
| | | |
| | | |
| | | |


## Questions

If you have any Python questions you'd like to explore with the group, please put your question and name in the sections below.

If you think you can help, feel free to contribute to the answers section!

### Question 1 - Question - Name

How can we use AI coding tools such as chatGPT help us learn Python more efficiently? 

```python
## Code for Q1
```

#### Answers
* 
*
*

### Question 2 - Strings manipulation problem - Nida
Add more details here

I want to: check the first occurence of the letter M in my strings (that can be 200 characters long, that's why I don't want to do it manually)

suppose I have this strings:
aminoacid_seq = 'SSSSATTVMHSSIVLATVLFVAIASASKTRELCMKSLEHAKVGTSKEAKQDGIDLYKHMFEHYPAMKKYFKHRENYTPADVQKDPFFIKQGQNILLACHVLCATYDDRETFDAYVGELMARHERDHVKVPNDVWNHFWEHFIEFLGSKTTLDEPTKHAWQEIGKEFSHEISHHGRHSVRDHCMNSLEYIAIGDKEHQKQNGIDLYKHMFEHYPHMRKAFKGRENFTKEDVQKDAFFVNKDTRFCWPFVCCDSSYDDEPTFDYFVDALMDRHIKDDIHLPQEQWHEFWKLFAEYLNEKSHQHLTEAEKHAWSTIGEDFAHEADKHAKAEKDHHEGEHKEEHH'

If I use this code:

M_loc = aminoacids_seq[0].find('M')
print(M_loc)
print(len(aminoacids_seq[0]))

am I correct?

```python
# -*- coding: utf-8 -*-
"""
Created on Thu Feb  1 10:56:35 2024

@author: uqcwest5
"""

# Initial problem

aminoacids_seq = 'SSSSATTVMHSSIVLATVLFVAIASASKTRELCMKSLEHAKVGTSKEAKQDGIDLYKHMFEHYPAMKKYFKHRENYTPADVQKDPFFIKQGQNILLACHVLCATYDDRETFDAYVGELMARHERDHVKVPNDVWNHFWEHFIEFLGSKTTLDEPTKHAWQEIGKEFSHEISHHGRHSVRDHCMNSLEYIAIGDKEHQKQNGIDLYKHMFEHYPHMRKAFKGRENFTKE*DVQKDAFFVNKDTRFCWPFVCCDSSYDDEPTFDYFVDALMDRHIKDDIHLPQEQWHEFWKLFAEYLNEKSHQHLTEAEKHAWSTIGEDFAHEADKHAKAEKDHHEGEHKEEHH'

M_loc = aminoacids_seq.find('M')
end_loc = aminoacids_seq.find('*')

aminoacids_seq[M_loc:end_loc + 1]

# New problem
# Count all the Ms
# Turn every section between Ms into a separate substring

import pandas as pd

count_M = aminoacids_seq.count("M")

M_start = aminoacids_seq.find('M')
M_end = aminoacids_seq.find('M', M_start + 1)

proteins = [aminoacids_seq[M_start:M_end]]

for i in range(1, count_M):
    M_start = M_end
    M_end = aminoacids_seq.find('M', M_start + 1)
    
    proteins.append(aminoacids_seq[M_start:M_end])
    
pd.Series(proteins).to_csv("proteins.csv")
    




```

#### Answers
* 
*
*

### Question 3 - Question - Name
Add more details here


```python
## Code for Q3
```

#### Answers
* 
*
*

### Question 4 - Example of Conditionals - Nida
Add more details here


```python
## Code for Q4
correct_ORF = []        
for seq in protseq_true:
    m_pos = seq.find("M")  
    m_end_seq = seq[m_pos:]
    if len(m_end_seq) > 100:
        print(m_end_seq)
        print(len(m_end_seq))
        correct_ORF.append(m_end_seq)
        
# fyi
protseq_true = ['CTIVFKRVCGVSAARLTPCGTGTSTDVVYRAFDIYNDKVAGFAKFLKTNCCRFQEKDEDDNLIDSYFVVKRHTFSNYQHEETIYNLLKDCPAVAKHDFFKFRIDGDMVPHISRQRLTKYTMADLVYALRHFDEGNCDTLKEILVTYNCCDDDYFNKKDWYDFVENPDILRVYANLGERVRQALLKTVQFCDAMRNAGIVGVLTLDNQDLNGNWYDFGDFIQTTPGSGVPVVDSYYSLLMPILTLTRALTAESHVDTDLTKPYIKWDLLKYDFTEERLKLFDRYFKYWDQTYHPNCVNCLDDRCILHCANFNVLFSTVFPPTSFGPLVRKIFVDGVPFVVSTGYHFRELGVVHNQDVNLHSSRLSFKELLVYAADPAMHAASGNLLLDKRTTCFSVAALTNNVAFQTVKPGNFNKDFYDFAVSKGFFKEGSSVELKHFFFAQDGNAAISDYDYYRYNLPTMCDIRQLLFVVEVVDKYFDCYDGGCINANQVIVNNLDKSAGFPFNKWGKARLYYDSMSYEDQDALFAYTKRNVIPTITQMNLKYAISAKNRARTVAGVSICSTMTNRQFHQKLLKSIAATRGATVVIGTSKFYGGWHNMLKTVYSDVENPHLMGWDYPKCDRAMPNMLRIMASLVLARKHTTCCSLSHRFYRLANECAQVLSEMVMCGGSLYVKPGGTSSGDATTAYANSVFNICQAVTANVNALLSTDGNKIADKYVRNLQHRLYECLYRNRDVDTDFVNEFYAYLRKHFSMMILSDDAVVCFNSTYASQGLVASIKNFKSVLYYQNNVFMSEAKCWTETDLTKGPHEFCSQHTMLVKQGDDYVYLPYPDPSRILGAGCFVDDIVKTDGTLMIERFVSLAIDAYPLTKHPNQEYADVFHLYLQYIRKLHDELTGHMLDMYSVMLTNDNTSRYWEPEFYEAMYTPHTVLQAVGACVLCNSQTSLRCGACIRRPFLCCKCCYDHVISTSHKLVLSVNPYVCNAPGCDVTDVTQLYLGGMSYYCKSHKPPISFPLCANGQVFGLYKNTCVGSDNVTDFNAIATCDWTNAGDYILANTCTERLKLFAAETLKATEETFKLSYGIATVREVLSDRELHLSWEVGKPRPPLNRNYVFTGYRVTKNSKVQIGEYTFEKGDYGDAVVYRGTTTYKLNVGDYFVLTSHTVMPLSAPTLVPQEHYVRITGLYPTLNISDEFSSNVANYQKVGMQKYSTLQGPPGTGKSHFAIGLALYYPSARIVYTACSHAAVDALCEKALKYLPIDKCSRIIPARARVECFDKFKVNSTLEQYVFCTVNALPETTADIVVFDEISMATNYDLSVVNARLRAKHYVYIGDPAQLPAPRTLLTKGTLEPEYFNSVCRLMKTIGPDMFLGTCRRCPAEIVDTVSALVYDNKLKAHKDKSAQCFKMFYKGVITHDVSSAINRPQIGVVREFLTRNPAWRKAVFISPYNSQNAVASKILGLPTQTVDSSQGSEYDYVIFTQTTETAHSCNVNRFNVAITRAKVGILCIMSDRDLYDKLQFTSLEIPRRNVATLQAENVTGLFKDCSKVITGLHPTQAPTHLSVDTKFKTEGLCVDIPGIPKDMTYRRLISMMGFKMNYQVNGYPNMFITREEAIRHVRAWIGFDVEGCHATREAVGTNLPLQLGFSTGVNLVAVPTGYVDTPNNTDFSRVSAKPPPGDQFKHLIPLMYKGLPWNVVRIKIVQMLSDTLKNLSDRVVFVLWAHGFELTSMKYFVKIGPERTCCLCDRRATCFSTASDTYACWHHSIGFDYVYNPFMIDVQQWGFTGNLQSNHDLYCQVHGNAHVASCDAIMTRCLAVHECFVKRVDWTIEYPIIGDELKINAACRKVQHMVVKAALLADKFPVLHDIGNPKAIKCVPQADVEWKFYDAQPCSDKAYKIEELFYSYATHSDKFTDGVCLFWNCNVDRYPANSIVCRFDTRVLSNLNLPGCDGGSLYVNKHAFHTPAFDKSAFVNLKQLPFFYYSDSPCESHGKQVVSDIDYVPLKSATCITRCNLGGAVCRHHANEYRLYLDAYNMMISAGFSLWVYKQFDTYNLWNTFTRLQSLENVAFNVVNKGHFDGQQGEVPVSIINNTVYTKVDGVDVELFENKTTLPVNVAFELWAKRNIKPVPEVKILNNLGVDIAANTVIWDYKRDAPAHISTIGVCSMTDIAKKPTETICAPLTVFFDGRVDGQVDLFRNARNGVLITEGSVKGLQPSVGPKQASLNGVTLIGEAVKTQFNYYKKVDGVVQQLPETYFTQSRNLQEFKPRSQMEIDFLELAMDEFIERYKLEGYAFEHIVYGDFSHSQLGGLHLLIGLAKRFKESPFELEDFIPMDSTVKNYFITDAQTGSSKCVCSVIDLLLDDFVEIIKSQDLSVVSKVVKVTIDYTEISFMLWCKDGHVETFYPKLQSSQAWQPGVAMPNLYKMQRMLLEKCDLQNYGDSATLPKGIMMNVAKYTQLCQYLNTLTLAVPYNMRVIHFGAGSDKGVAPGTAVLRQWLPTGTLLVDSDLNDFVSDADSTLIGDCATVHTANKWDLIISDMYDPKTKNVTKENDSKEGFFTYICGFIQQKLALGGSVAIKITEHSWNADLYKLMGHFAWWTAFVTNVNASSSEAFLIGCNYLGKPREQIDGYVMHANYIFWRNTNPIQLSSYSLFDMSKFPLKLRGTAVMSLKEGQINDMILSLLSKGRLIIRENNRVVISSDVLVNN', 'ASAQRSQITLHINELMDLFMRIFTIGTVTLKQGEIKDATPSDFVRATATIPIQASLPFGWLIVGVALLAVFQSASKIITLKKRWQLALSKGVHFVCNLLLLFVTVYSHLLLVAAGLEAPFLYLYALVYFLQSINFVRIIMRLWLCWKCRSKNPLLYDANYFLCWHTNCYDYCIPYNSVTSSIVITSGDGTTSPISEHDYQIGGYTEKWESGVKDCVVLHSYFTSDYYQLYSTQLSTDTGVEHVTFFIYNKIVDEPEEHVQIHTIDGSSGVVNPVMEPIYDEPTTTTSVPL', 'TNMKIILFLALITLATCELYHYQECVRGTTVLLKEPCSSGTYEGNSPFHPLADNKFALTCFSTQFAFACPDGVKHVYQLRARSVSPKLFIRQEEVQELYSPIFLIVAAIVFITLCFTLKRKTE', 'PKGKMESLVPGFNEKTHVQLSLPVLQVRDVLVRGFGDSVEEVLSEARQHLKDGTCGLVEVEKGVLPQLEQPYVFIKRSDARTAPHGHVMVELVAELEGIQYGRSGETLGVLVPHVGEIPVAYRKVLLRKNGNKGAGGHSYGADLKSFDLGDELGTDPYEDFQENWNTKHSSGVTRELMRELNGGAYTRYVDNNFCGPDGYPLECIKDLLARAGKASCTLSEQLDFIDTKRGVYCCREHEHEIAWYTERSEKSYELQTPFEIKLAKKFDTFNGECPNFVFPLNSIIKTIQPRVEKKKLDGFMGRIRSVYPVASPNECNQMCLSTLMKCDHCGETSWQTGDFVKATCEFCGTENLTKEGATTCGYLPQNAVVKIYCPACHNSEVGPEHSLAEYHNESGLKTILRKGGRTIAFGGCVFSYVGCHNKCAYWVPRASANIGCNHTGVVGEGSEGLNDNLLEILQKEKVNINIVGDFKLNEEIAIILASFSASTSAFVETVKGLDYKAFKQIVESCGNFKVTKGKAKKGAWNIGEQKSILSPLYAFASEAARVVRSIFSRTLETAQNSVRVLQKAAITILDGISQYSLRLIDAMMFTSDLATNNLVVMAYITGGVVQLTSQWLTNIFGTVYEKLKPVLDWLEEKFKEGVEFLRDGWEIVKFISTCACEIVGGQIVTCAKEIKESVQTFFKLVNKFLALCADSIIIGGAKLKALNLGETFVTHSKGLYRKCVKSREETGLLMPLKAPKEIIFLEGETLPTEVLTEEVVLKTGDLQPLEQPTSEAVEAPLVGTPVCINGLMLLEIKDTEKYCALAPNMMVTNNTFTLKGGAPTKVTFGDDTVIEVQGYKSVNITFELDERIDKVLNEKCSAYTVELGTEVNEFACVVADAVIKTLQPVSELLTPLGIDLDEWSMATYYLFDESGEFKLASHMYCSFYPPDEDEEEGDCEEEEFEPSTQYEYGTEDDYQGKPLEFGATSAALQPEEEQEEDWLDDDSQQTVGQQDGSEDNQTTTIQTIVEVQPQLEMELTPVVQTIEVNSFSGYLKLTDNVYIKNADIVEEAKKVKPTVVVNAANVYLKHGGGVAGALNKATNNAMQVESDDYIATNGPLKVGGSCVLSGHNLAKHCLHVVGPNVNKGEDIQLLKSAYENFNQHEVLLAPLLSAGIFGADPIHSLRVCVDTVRTNVYLAVFDKNLYDKLVSSFLEMKSEKQVEQKIAEIPKEEVKPFITESKPSVEQRKQDDKKIKACVEEVTTTLEETKFLTENLLLYIDINGNLHPDSATLVSDIDITFLKKDAPYIVGDVVQEGVLTAVVIPTKKAGGTTEMLAKALRKVPTDNYITTYPGQGLNGYTVEEAKTVLKKCKSAFYILPSIISNEKQEILGTVSWNLREMLAHAEETRKLMPVCVETKAIVSTIQRKYKGIKIQEGVVDYGARFYFYTSKTTVASLINTLNDLNETLVTMPLGYVTHGLNLEEAARYMRSLKVPATVSVSSPDAVTAYNGYLTSSSKTPEEHFIETISLAGSYKDWSYSGQSTQLGIEFLKRGDKSVYYTSNPTTFHLDGEVITFDNLKTLLSLREVRTIKVFTTVDNINLHTQVVDMSMTYGQQFGPTYLDGADVTKIKPHNSHEGKTFYVLPNDDTLRVEAFEYYHTTDPSFLGRYMSALNHTKKWKYPQVNGLTSIKWADNNCYLATALLTLQQIELKFNPPALQDAYYRARAGEAANFCALILAYCNKTVGELGDVRETMSYLFQHANLDSCKRVLNVVCKTCGQQQTTLKGVEAVMYMGTLSYEQFKKGVQIPCTCGKQATKYLVQQESPFVMMSAPPAQYELKHGTFTCASEYTGNYQCGHYKHITSKETLYCIDGALLTKSSEYKGPITDVFYKENSYTTTIKPVTYKLDGVVCTEIDPKLDNYYKKDNSYFTEQPIDLVPNQPYPNASFDNFKFVCDNIKFADDLNQLTGYKKPASRELKVTFFPDLNGDVVAIDYKHYTPSFKKGAKLLHKPIVWHVNNATNKATYKPNTWCIRCLWSTKPVETSNSFDVLKSEDAQGMDNLACEDLKPVSEEVVENPTIQKDVLECNVKTTEVVGDIILKPANNSLKITEEVGHTDLMAAYVDNSSLTIKKPNELSRVLGLKTLATHGLAAVNSVPWDTIANYAKPFLNKVVSTTTNIVTRCLNRVCTNYMPYFFTLLLQLCTFTRSTNSRIKASMPTTIAKNTVKSVGKFCLEASFNYLKSPNFSKLINIIIWFLLLSVCLGSLIYSTAALGVLMSNLGMPSYCTGYREGYLNSTNVTIATYCTGSIPCSVCLSGLDSLDTYPSLETIQITISSFKWDLTAFGLVAEWFLAYILFTRFFYVLGLAAIMQLFFSYFAVHFISNSWLMWLIINLVQMAPISAMVRMYIFFASFYYVWKSYVHVVDGCNSSTCMMCYKRNRATRVECTTIVNGVRRSFYVYANGGKGFCKLHNWNCVNCDTFCAGSTFISDEVARDLSLQFKRPINPTDQSSYIVDSVTVKNGSIHLYFDKAGQKTYERHSLSHFVNLDNLRANNTKGSLPINVIVFDGKSKCEESSAKSASVYYSQLMCQPILLLDQALVSDVGDSAEVAVKMFDAYVNTFSSTFNVPMEKLKTLVATAEAELAKNVSLDNVLSTFISAARQGFVDSDVETKDVVECLKLSHQSDIEVTGDSCNNYMLTYNKVENMTPRDLGACIDCSARHINAQVAKSHNIALIWNVKDFMSLSEQLRKQIRSAAKKNNLPFKLTCATTRQVVNVVTTKIALKGGKIVNNWLKQLIKVTLVFLFVAAIFYLITPVHVMSKHTDFSSEIIGYKAIDGGVTRDIASTDTCFANKHADFDTWFSQRGGSYTNDKACPLIAAVITREVGFVVPGLPGTILRTTNGDFLHFLPRVFSAVGNICYTPSKLIEYTDFATSACVLAAECTIFKDASGKPVPYCYDTNVLEGSVAYESLRPDTRYVLMDGSIIQFPNTYLEGSVRVVTTFDSEYCRHGTCERSEAGVCVSTSGRWVLNNDYYRSLPGVFCGVDAVNLLTNMFTPLIQPIGALDISASIVAGGIVAIVVTCLAYYFMRFRRAFGEYSHVVAFNTLLFLMSFTVLCLTPVYSFLPGVYSVIYLYLTFYLTNDVSFLAHIQWMVMFTPLVPFWITIAYIICISTKHFYWFFSNYLKRRVVFNGVSFSTFEEAALCTFLLNKEMYLKLRSDVLLPLTQYNRYLALYNKYKYFSGAMDTTSYREAACCHLAKALNDFSNSGSDVLYQPPQTSITSAVLQSGFRKMAFPSGKVEGCMVQVTCGTTTLNGLWLDDVVYCPRHVICTSEDMLNPNYEDLLIRKSNHNFLVQAGNVQLRVIGHSMQNCVLKLKVDTANPKTPKYKFVRIQPGQTFSVLACYNGSPSGVYQCAMRPNFTIKGSFLNGSCGSVGFNIDYDCVSFCYMHHMELPTGVHAGTDLEGNFYGPFVDRQTAQAAGTDTTITVNVLAWLYAAVINGDRWFLNRFTTTLNDFNLVAMKYNYEPLTQDHVDILGPLSAQTGIAVLDMCASLKELLQNGMNGRTILGSALLEDEFTPFDVVRQCSGVTFQSAVKRTIKGTHHWLLLTILTSLLVLVQSTQWSLFFFLYENAFLPFAMGIIAMSAFAMMFVKHKHAFLCLFLLPSLATVAYFNMVYMPASWVMRIMTWLDMVDTSLSGFKLKDCVMYASAVVLLILMTARTVYDDGARRVWTLMNVLTLVYKVYYGNALDQAISMWALIISVTSNYSGVVTTVMFLARGIVFMCVEYCPIFFITGNTLQCIMLVYCFLGYFCTCYFGLFCLLNRYFRLTLGVYDYLVSTQEFRYMNSQGLLPPKNSIDAFKLNIKLLGVGGKPCIKVATVQSKMSDVKCTSVVLLSVLQQLRVESSSKLWAQCVQLHNDILLAKDTTEAFEKMVSLLSVLLSMQGAVDINKLCEEMLDNRATLQAIASEFSSLPSYAAFATAQEAYEQAVANGDSEVVLKKLKKSLNVAKSEFDRDAAMQRKLEKMADQAMTQMYKQARSEDKRAKVTSAMQTMLFTMLRKLDNDALNNIINNARDGCVPLNIIPLTTAAKLMVVIPDYNTYKNTCDGTTFTYASALWEIQQVVDADSKIVQLSEISMDNSPNLAWPLIVTALRANSAVKLQNNELSPVALRQMSCAAGTTQTACTDDNALAYYNTTKGGRFVLALLSDLQDLKWARFPKSDGTGTIYTELEPPCRFVTDTPKGPKVKYLYFIKGLNNLNRGMVLGSLAATVRLQAGNATEVPANSTVLSFCAFAVDAAKAYKDYLASGGQPITNCVKMLCTHTGTGQAITVTPEANMDQESFGGASCCLYCRCHIDHPNPKGFCDLKGKYVQIPTTCANDPVGFTLKNTVCTVCGMWKGYGCSCDQLREPMLQSADAQSFLNGFAV', 'LEKTTELLFLVMFLLTTKRTMFVFLVLLPLVSSQCVNLTTRTQLPPAYTNSFTRGVYYPDKVFRSSVLHSTQDLFLPFFSNVTWFHAIHVSGTNGTKRFDNPVLPFNDGVYFASTEKSNIIRGWIFGTTLDSKTQSLLIVNNATNVVIKVCEFQFCNDPFLGVYYHKNNKSWMESEFRVYSSANNCTFEYVSQPFLMDLEGKQGNFKNLREFVFKNIDGYFKIYSKHTPINLVRDLPQGFSALEPLVDLPIGINITRFQTLLALHRSYLTPGDSSSGWTAGAAAYYVGYLQPRTFLLKYNENGTITDAVDCALDPLSETKCTLKSFTVEKGIYQTSNFRVQPTESIVRFPNITNLCPFGEVFNATRFASVYAWNRKRISNCVADYSVLYNSASFSTFKCYGVSPTKLNDLCFTNVYADSFVIRGDEVRQIAPGQTGKIADYNYKLPDDFTGCVIAWNSNNLDSKVGGNYNYLYRLFRKSNLKPFERDISTEIYQAGSTPCNGVEGFNCYFPLQSYGFQPTNGVGYQPYRVVVLSFELLHAPATVCGPKKSTNLVKNKCVNFNFNGLTGTGVLTESNKKFLPFQQFGRDIADTTDAVRDPQTLEILDITPCSFGGVSVITPGTNTSNQVAVLYQDVNCTEVPVAIHADQLTPTWRVYSTGSNVFQTRAGCLIGAEHVNNSYECDIPIGAGICASYQTQTNSPRRARSVASQSIIAYTMSLGAENSVAYSNNSIAIPTNFTISVTTEILPVSMTKTSVDCTMYICGDSTECSNLLLQYGSFCTQLNRALTGIAVEQDKNTQEVFAQVKQIYKTPPIKDFGGFNFSQILPDPSKPSKRSFIEDLLFNKVTLADAGFIKQYGDCLGDIAARDLICAQKFNGLTVLPPLLTDEMIAQYTSALLAGTITSGWTFGAGAALQIPFAMQMAYRFNGIGVTQNVLYENQKLIANQFNSAIGKIQDSLSSTASALGKLQDVVNQNAQALNTLVKQLSSNFGAISSVLNDILSRLDKVEAEVQIDRLITGRLQSLQTYVTQQLIRAAEIRASANLAATKMSECVLGQSKRVDFCGKGYHLMSFPQSAPHGVVFLHVTYVPAQEKNFTTAPAICHDGKAHFPREGVFVSNGTHWFVTQRNFYEPQIITTDNTFVSGNCDVVIGIVNNTVYDPLQPELDSFKEELDKYFKNHTSPDVDLGDISGINASVVNIQKEIDRLNEVAKNLNESLIDLQELGKYEQYIKWPWYIWLGFIAGLIAIVMVTIMLCCMTSCCSCLKGCCSCGSCCKFDEDDSEPVLKGVKLHYT', 'RSCCFRFHLNEQTKMSDNGPQNQRNAPRITFGGPSDSTGSNQNGERSGARSKQRRPQGLPNNTASWFTALTQHGKEDLKFPRGQGVPINTNSSPDDQIGYYRRATRRIRGGDGKMKDLSPRWYFYYLGTGPEAGLPYGANKDGIIWVATEGALNTPKDHIGTRNPANNAAIVLQLPQGTTLPKGFYAEGSRGGSQASSRSSSRSRNSSRNSTPGSSRGTSPARMAGNGGDAALALLLLDRLNQLESKMSGKGQQQQGQTVTKKSAAEASKKPRQKRTATKAYNVTQAFGRRGPEQTQGNFGDQELIRQGTDYKHWPQIAQFAPSASAFFGMSRIGMEVTPSGTWLTYTGAIKLDDKDPNFKDQVILLNKHIDAYKTFPPTEPKKDKKKKADETQALPQRQKKQQTVTLLPAADLDDFSKQLQQSMSSADSTQA', 'TACTCLKNIRTCRINTPSRSKLICMNSNRDFCAVNILIKNSNLVRSICSWCYNTDTTKRTWCNVKNLKCLWITDSISSVSNVSAKLLERQKLFVRLSKNTCAC', 'FGCCCKRYYVQGNTTISCIVDNVVECIIIQLSKHSEKHCLHSTSNFCPLVLRSSLFIHLGHSLISHLFQLTLHGCITVKFRFSHIQRLLQLFKNNFRITISNSLLISFLSSSKSCI', 'FRYWLQSFYDSICHNTGELIYFCTEFNCIGRALLIKYFINPFIKFKSDIHTLVTLHFYHSVITKSNLCWCTAFECEGIVCYHHIRCKGTVLFCVFDFEQHKPVNTNWCTNQWSFNSFTSRLF', 'FLFTNIPGTFFSFSFCNFKITTGFNNLFECFIIQTFHSFHKSTCGSRKRCQNNGDLFIKFKVTNNIDVDFLFLEYFKKVVIKTFGTFSNNTCMVTTYVSASTWNPIGTLVMATNIREHTASKGNSATTLTKNGFQARFIMVFGKTMLRSYF', 'IRRPSPYLLLITLLMLLLKSVNFNFVMIHFWVFITTKTTKVGWKVSSEFILVRIIALLNMSLSLFLWTLKENRVISKILGNLCLRILMVILKYILSTRLLI', 'SSGLNELNIILVFLFGTLILAMADSNGTITVEELKKLLEQWNLVIGFLFLTWICLLQFAYANRNRFLYIIKLIFLWLLWPVTLACFVLAAVYRINWITGGIAIAMACLVGLMWLSYFIASFRLFARTRSMWSFNPETNILLNVPLHGTILTRPLLESELVIGAVILRGHLRIAGHHLGRCDIKDLPKEITVATSRTLSYYKLGASQRVAGDSGFAAYSRYRIGNYKLNTDHSSSSDNIALLVQ', 'TNMKFLVFLGIITTVAAFHQECSLQSCTQHQPYVVDDPCPIHFYSKWYIRVGARKSAPLIELCVDEAGSKSPIQYIDIGNYTVSCLPFTINCQEPKLGSLVVRCSFYEDFLEYHDVRVVLDFI', 'TNKLKCLIMDPKISEMHPALRLVDPQIQLAVTRMENAVGRDQNNVGPKVYPIILRLGSPLSLNMARKTLNSLEDKAFQLTPIAVQMTKLATTEELPDEFVVVTVK', 'SVPCLISSWSPKFPWVCSGPRLPKACVTLYALVAVRFCRGFLEASAADFLVTVWPCCCWPLPDILLSSWFNLSSSSKARAASPPLPAILAGEVPLLLPGVEFLELLRLRDEEREEA', 'RTATWLEVFVPGVITLTPPKEHGVMSRISSVCGSRTASVVSAMSLPNCWKGRNFLLDSVRTPVPVKPLKLKLTHLFLTKLVDFLGPQTVAGACRSSKESTTTLYGW', 'AAIRSVWPTSSVIFKLLFAGLSIMSPTTSVVFTLHSRTSFCMVGFSTTSSETGFRSSQARLSIPCASSDFSTSNEFDVSTGFVLQRQRIHQVFGLYVALLVALLTCQTIGLCNNLAPFLKEGV', 'PCTSITVSSPKVTFVGAPPLSVKVLFVTIILGARAQYFSVSLISSNISPLIQTGVPTNGASTASLVGCSNGCKSPVFKTTSSVNTSVGSVSPSKKIISFGAFRGMSRPVSSLDLTHFLYNPFECVTNVSPKFKALSLAPPIMIESAHKAKNLFTSLKNV']
```

#### Answers
* 
*
*

### Question 5 - Question - Name
Add more details here


```python

```

#### Answers
* 
*
*

### Question 6 - Question - Name
Add more details here


```python
## Code for Q6
```

#### Answers
* 
*
*
023e33
# 2023-12-07: UQ PUG 4
**Access the notebook (.ipynb) file for this session [here](https://github.com/uqlibrary/technology-training/blob/bfd0ebf3569be0789e972b359461fef3dbe0e3d4/Python/PUG_notebooks/2023-12-07_%20UQ%20PUG%204.ipynb).**

Welcome to UQ Python User Group! Check out our [general information](https://app.noteable.io/f/c84cf34f-03eb-48eb-aff4-ccf80b013b5c/UQ-PUG-General-Info.ipynb?cellID=1e2cf356) for details about who we are and what we do.

## Structure

1. We start today by adding our names to the table below
1. Add your questions to this page
1. This month's presentation
1. Finally, we spend the rest of the session answering the questions you've brought!

## Mailing list

If you would like to be on the mailing list and receive the latest PUG updates, please sign up here:

https://forms.office.com/r/6qvfFX0qGr

Feel free to send this link to anyone you think may benefit.

## Training Resources

We offer Python training sessions and resources, you can find our introductory guide [here](https://github.com/uqlibrary/technology-training/blob/master/Python/python_intro/python_intro.md).

## Introduce yourself
| What's your name? | Where are you from? | Why are you here? |
| --- | --- | --- |
|Karen | UQ Busines School |to learn |
| Cameron | UQ Library | To help and learn|
| | | |
|Po-Yen |UQ Business school |Get some help and learn I guess :) |
| | | |
| Sagar |Bangladesh | Learn Python |
| | ||
| | | |
| | | |
| | | |
| | | |
| | | |
| | | |
| | | |
| | | |
| | | |
| | | |
| | | |
| | | |
| | | |

## Questions

If you have any Python questions you'd like to explore with the group, please put them in a markdown cell, with any code you'd like us to run in a Python cell.

### Question 1 - Question - Name
Question about the CycleGAN architecture. Po-Yen


```python
#I don't get the part under "try" and the part of "except"
#I also find that onece I load TPU, I have to wait to use this engine
import tensorflow as tf
from tensorflow import keras
from tensorflow.keras import layers
import tensorflow_addons as tfa

from kaggle_datasets import KaggleDatasets
import matplotlib.pyplot as plt
import numpy as np

try:
    tpu = tf.distribute.cluster_resolver.TPUClusterResolver()
    print('Device:', tpu.master())
    tf.config.experimental_connect_to_cluster(tpu)
    tf.tpu.experimental.initialize_tpu_system(tpu)
    strategy = tf.distribute.experimental.TPUStrategy(tpu)
except:
    strategy = tf.distribute.get_strategy()
print('Number of replicas:', strategy.num_replicas_in_sync)

AUTOTUNE = tf.data.experimental.AUTOTUNE
    
print(tf.__version__)
```


```python
a = 5

try:
    "apple"**2
except ValueError:
    print("We're inside the valueerror section")
except TypeError:
    print("We're inside the typeerror section")

    
```

## Answers
You may be able to process your data on some kind of HPC/loud computing platform.

At UQ, you can get access to the [Weiner HPC](https://rcc.uq.edu.au/article/2019/10/rcc-supports-ai-research-uq), which has GPUs optimised for ML.

You should still be eligible for [Nectar](https://ardc.edu.au/services/ardc-nectar-research-cloud/). This should be fairly easy to sign up to, but your access may disappear when you graduate.

You might be able to sign up for [MLeRP](https://docs.mlerp.cloud.edu.au/). 
This may take more effort to sign up to thena Nectar, but in my previous discussions with people at MLeRP, they may be more accepting of people who aren't attached to a research institution.

### Question 2 - Question - Name
Add more details here


```python
!pip install -qU langchain openai transformers
```


```python
from langchain.tools import BaseTool
from langchain.agents import initialize_agent
```


```python
help(initialize_agent)
```


```python
## Can you tell me what does the error code mean

agent(f"What does this image show?\n{img_url}")

> Entering new AgentExecutor chain...
{
    "action": "Image captioner",
    "action_input": "https://images.unsplash.com/photo-1616128417859-3a984dd35f02?ixlib=rb-4.0.3&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=2372&q=80"
}
---------------------------------------------------------------------------
NameError                                 Traceback (most recent call last)
~\AppData\Local\Temp\ipykernel_5440\710257616.py in <module>
----> 1 agent(f"What does this image show?\n{img_url}")

~\anaconda3\lib\site-packages\langchain\chains\base.py in __call__(self, inputs, return_only_outputs, callbacks, tags, metadata, run_name, include_run_info)
    310         except BaseException as e:
    311             run_manager.on_chain_error(e)
--> 312             raise e
    313         run_manager.on_chain_end(outputs)
    314         final_outputs: Dict[str, Any] = self.prep_outputs(

~\anaconda3\lib\site-packages\langchain\chains\base.py in __call__(self, inputs, return_only_outputs, callbacks, tags, metadata, run_name, include_run_info)
    304         try:
    305             outputs = (
--> 306                 self._call(inputs, run_manager=run_manager)
    307                 if new_arg_supported
    308                 else self._call(inputs)

~\anaconda3\lib\site-packages\langchain\agents\agent.py in _call(self, inputs, run_manager)
   1310         # We now enter the agent loop (until it returns something).
   1311         while self._should_continue(iterations, time_elapsed):
-> 1312             next_step_output = self._take_next_step(
   1313                 name_to_tool_map,
   1314                 color_mapping,

~\anaconda3\lib\site-packages\langchain\agents\agent.py in _take_next_step(self, name_to_tool_map, color_mapping, inputs, intermediate_steps, run_manager)
   1036     ) -> Union[AgentFinish, List[Tuple[AgentAction, str]]]:
   1037         return self._consume_next_step(
-> 1038             [
   1039                 a
   1040                 for a in self._iter_next_step(

~\anaconda3\lib\site-packages\langchain\agents\agent.py in <listcomp>(.0)
   1036     ) -> Union[AgentFinish, List[Tuple[AgentAction, str]]]:
   1037         return self._consume_next_step(
-> 1038             [
   1039                 a
   1040                 for a in self._iter_next_step(

~\anaconda3\lib\site-packages\langchain\agents\agent.py in _iter_next_step(self, name_to_tool_map, color_mapping, inputs, intermediate_steps, run_manager)
   1132                     tool_run_kwargs["llm_prefix"] = ""
   1133                 # We then call the tool on the tool input to get an observation
-> 1134                 observation = tool.run(
   1135                     agent_action.tool_input,
   1136                     verbose=self.verbose,

~\anaconda3\lib\site-packages\langchain_core\tools.py in run(self, tool_input, verbose, start_color, color, callbacks, tags, metadata, run_name, **kwargs)
    363         except (Exception, KeyboardInterrupt) as e:
    364             run_manager.on_tool_error(e)
--> 365             raise e
    366         else:
    367             run_manager.on_tool_end(

~\anaconda3\lib\site-packages\langchain_core\tools.py in run(self, tool_input, verbose, start_color, color, callbacks, tags, metadata, run_name, **kwargs)
    337                 self._run(*tool_args, run_manager=run_manager, **tool_kwargs)
    338                 if new_arg_supported
--> 339                 else self._run(*tool_args, **tool_kwargs)
    340             )
    341         except ToolException as e:

~\AppData\Local\Temp\ipykernel_5440\1932156217.py in _run(self, url)
     12         image = Image.open(requests.get(img_url, stream=True).raw).convert('RGB')
     13         # preprocess the image
---> 14         inputs = processor(image, return_tensors="pt").to(device)
     15         # generate the caption
     16         out = model.generate(**inputs, max_new_tokens=20)

NameError: name 'processor' is not defined
```

### Question 3 - Question - Name
Add more details here


```python
## Code for Q3
```

### Question 4 - Question - Name
Add more details here


```python
## Code for Q4
```

### Question 5 - Question - Name
Add more details here


```python

```

### Question 6 - Question - Name
Add more details here


```python
## Code for Q6
```


# 2023-11-02: UQ PUG 3

**Access the notebook (.ipynb) file for this session [here](https://github.com/uqlibrary/technology-training/blob/bfd0ebf3569be0789e972b359461fef3dbe0e3d4/Python/PUG_notebooks/2023-11-02_%20UQ%20PUG%203.ipynb).**

Welcome to UQ Python User Group! Check out our [general information](https://app.noteable.io/f/c84cf34f-03eb-48eb-aff4-ccf80b013b5c/UQ-PUG-General-Info.ipynb?cellID=1e2cf356) for details about who we are and what we do.

## Structure

1. We start today by adding our names to the table below
1. Add your questions to this page
1. This month's presentation
1. Finally, we spend the rest of the session answering the questions you've brought!

## This month's presentation

Our first guest speaker for PUG will be Nikhil Jangamreddy, please make him feel welcome!

Today, Nikhil presented about integrating ChatGPT with Python, demonstrating some applications.

Some interesting tools explored/mentioned
- ChatGPT (and the API)
- Deeplearning.ai
- poe
- streamlit
- langchain
- Mistral
- Seminal work: Attention Is All You Need

## Introduce yourself
| What's your name? | Where are you from? | Why are you here? |
| --- | --- | --- |
| Cameron West | UQ Library | To learn and help |
Karen Fang|Business School |To learn :) | |
| Nicholas Wiggins|UQ Library |Learn and help! |
|Nikhil | EECS UQ | Learn|
| Valentina Urrutia Guada | UQ Library | To learn and help|
| | | |
| | | |
| | | |
| | | |
| | | |
| | | |
| | | |
| | | |
| | | |
| | | |
| | | |
| | | |
| | | |
| | | |
| | | |

## Questions

If you have any Python questions you'd like to explore with the group, please put them in a markdown cell, with any code you'd like us to run in a Python cell.

### Question 1 - Model installation Question -Karen
Fail to install the package

https://allenai.github.io/scispacy/

en_ner_bc5cdr_md

#### Solution

See code below, we can install using the download link.


```python
# Example install
!pip install https://s3-us-west-2.amazonaws.com/ai2-s2-scispacy/releases/v0.5.3/en_ner_bc5cdr_md-0.5.3.tar.gz
```


```python
## How to install modules:
!pip install #<module url> access this by copying the download link for the module

import spacy

# Load the spaCy English language model
nlp = spacy.load('<module name>')
```

### Question 2 - Question - Name
Add more details here


```python
## Code for Q2
```

### Question 3 - Question - Name
Add more details here


```python
## Code for Q3
```

### Question 4 - Question - Name
Add more details here


```python
## Code for Q4
```

### Question 5 - Question - Name
Add more details here


```python
## Code for Q5
```

### Question 6 - Question - Name
Add more details here


```python
## Code for Q6
```

# 2023-10-05: UQ PUG 2
**Access the notebook (.ipynb) file for this session [here](https://github.com/uqlibrary/technology-training/blob/bfd0ebf3569be0789e972b359461fef3dbe0e3d4/Python/PUG_notebooks/2023-10-05_%20UQ%20PUG%202.ipynb).**

Welcome to UQ Python User Group! Check out our [general information](https://app.noteable.io/f/c84cf34f-03eb-48eb-aff4-ccf80b013b5c/UQ-PUG-General-Info.ipynb?cellID=1e2cf356) for details about who we are and what we do.

## Structure

1. We start today by adding our names to the table below
1. Add your questions to this page
1. This month's presentation
1. Finally, we spend the rest of the session answering the questions you've brought!

## This month's presentation

https://forms.office.com/r/TTLGSAxS0k

Join us for an informative presentation that delves into the world of Python Integrated Development Environments (IDEs). In this session, we will compare and contrast five popular Python development environments: Spyder, PyCharm, Visual Studio Code (VSCode), Google Colab, and the trusty Command Prompt.

https://www.meetup.com/beginners-python-machine-learning/

## Introduce yourself
| What's your name? | Where are you from? | Why are you here? |
| --- | --- | --- |
|Luke |Library |To learn and attempt help |
|Mads |EAIT |Analyse data and hopefully get some help doing that |
|Taneesha |School of the Environment: Conservation Science |Learn python coding for ArcGIS |
|Cameron | Library | To learn and help!|
|Nida |School of Chemistry & Molecular Biosciences|To learn more about python to work on molec bio data|
|Nick Wiggins |Library |Here to help and mostly to learn |
|Annie |SENV |here to ask all the questions! |
| | | |
| | | |
| | | |
| | | |
| | | |
| | | |
| | | |
| | | |
| | | |
| | | |
| | | |
| | | |
| | | |

## Questions

If you have any Python questions you'd like to explore with the group, please put them in a markdown cell, with any code you'd like us to run in a Python cell.

### Question 1 - What are some "best practices" or the "correct" way of installing Python for the first time - Annie
I frequently get "path" errors because I'm installed python somewhere and then the IDE can't find the path to Python (I think), and many "hardcore" programmers don't like Anaconda - they say it interferes with pip so what is the easiest both initially and later on down the line?

Nick - I'm going to try installing Python and vsCode using these instructions (https://github.com/Oracen/python-intro), and put all the files into one folder as Luke suggested


```python
## Code for Q1
```

### Question 2 - Question - Nida
In Spyder, sometimes when we want to import a module (i.e a .py file that contains certain functions/dictionary), it gives this error: 

ModuleNotFoundError: No module named 'translate'

is this problem related to whether the file that we are trying to import is not saved in our working directory? 

How do we set that our working directory is in the place where we saved our file that we want to import as a module?

I saw an Icon called "browse a working directory" in the top right of the Spyder, is this how we set our working directory? Or do we have to do sth else to change our working directory?

Thank you so much


```python
# Access the system (using the module sys)
import sys

# This will display where you can put your modules
print(sys.path)

# This will add another location to the path (another folder where you can load modules)
sys.path = sys.path + ['Location of your modules']
```

https://www.w3schools.com/python/python_ref_keywords.asp
avoid to name your files or variables with these words or python will get confused!


#### Luke attempting to find answers

The 'translate' module is causing a conflict - https://pypi.org/project/translate/

This says you can do pip install to file path? - https://stackoverflow.com/questions/63790682/importing-custom-modules-py-files-into-virtual-environment#:~:text=You%20can%20create%20a%20setup.py%2C%20then%20install%20this,a%20module%20by%20pip%20pip%20install%20-e%20%2Fpath%2Fto%2Ffolder


```python
pip install translate
```

### Question 3 - should you always be using venv (virtual environments) for every new project? - Annie
what are the pros and cons of venv?


```python
## Code for Q3
```

### Question 4 - where does one find packages available in Notable? e.g. google colab doesnt have all packages - Annie

Add more details here


```python
## Code for Q4
help('modules')
```

### Question 5 - Why does it sometimes take so long to use google collab? (i.e when we have to re-run everything again) is it bcs it is run the server which is different from server that we use to run our code with other environment? do we have place to store our .csv file?


```python
## Code for Q5
```

### Question 6 - How do I fix an IndexError: list index out of range? -Taneesha
Writing python code in ArcGIS to loop through a number of geoprocessing tools


```python
numbers = [0,1,2]

letters = ["a","b"]

for i in numbers:
    print(letters[i])
```

Question 7 - do we have tools for running it line by line in spyder?


```python

```

Luke you mentioned you were interested in this - feel free to delete once you've seen this. https://www.deeplearning.ai/short-courses/langchain-chat-with-your-data/

Thanks Jason. I have a playlist of YTs to work my way through currently. Found a channel where one of the videos I had some success with.
This video - https://www.youtube.com/watch?v=wrD-fZvT6UI.
So am trying more of his tutorials. Trying to do it without OpenAI API


# 2023-09-07: UQ PUG 1

**Access the notebook (.ipynb) file for this session [here](https://github.com/uqlibrary/technology-training/blob/bfd0ebf3569be0789e972b359461fef3dbe0e3d4/Python/PUG_notebooks/2023-09-07_%20UQ%20PUG%201.ipynb).** Note that the formatting has failed for some of Nida's question.

Welcome to UQ Python User Group! Check out our [general information](https://app.noteable.io/f/c84cf34f-03eb-48eb-aff4-ccf80b013b5c/UQ-PUG-General-Info.ipynb?cellID=1e2cf356) for details about who we are and what we do.

## Structure
1. We will start today by having everyone add their names to this page.
1. Add your questions to this page.
1. This Month's Presentation.
1. Finally we will spend the rest of the session answering the questions you have brought!

## This month's presentation

Welcome to our first Python User Group gathering! This month, Luke and Cameron give an overview of the group, our vision and Noteable, the interactive collaborative notebook platform which can run markdown, Python, R and SQL. 

## Introduce yourself
| What's your name? | Where are you from? | Why are you here? | 
| --- | --- | --- |
|Luke |Library |Learn |
|Nick |Library |Learn |
|Valentina Urrutia Guada |Library |Learn |
|Nida  |School of Molecular Biology |(1) Understanding the logic (in some codes) for bioinformatics and metagenomics application, (2) Learn how to visualize data in python that is hard to do in excel |
| Cameron | Library | Learn |
|Sam Hames |  School of Languages and Cultures| Community|
|Nikhil |School of EECS | Learn|
| Paul Vrbik | EECS | Support |
| Jason Dail| SENV |  Learn |
|Annie Nguyen |SENV | Learn :)| 


## Research tools

Here are a few links we shared around, mostly from Jason.

1.  [to assist with academic citations](https://scite.ai/)

1.  https://researchrabbitapp.com/home  helpful when making research collections, mapping concepts, and looking at the linkages between references
1.  https://consensus.app/
1.  https://chat.openai.com/
1.  https://article-summarizer.scholarcy.com/summarizer
1. https://typeset.io/ AI assistant for reading and understanding papers
1. https://www.listendata.com/2023/03/how-to-run-chatgpt-inside-excel.html (excel extension for chat GPT how-to)
1. EECS tutor help: https://eecs.uq.edu.au/current-students/eecs-learning-centre-tutors

## Questions

If you have any Python questions you'd like to explore with the group, please put them in a markdown cell, with any code you'd like us to run in a Python cell.

### Question 1 - Finding substrings for COVID sequencing - Nida

Nida has a problem where she needs to identify specific substrings from a large sequence of characters (DNA sequence). Her code is below

I just found out that the code:

```python
covid_seq = getSequence('MN908947', 'genbank', DNA_Alphabet) 
```

is actually trying to get a DNA sequence of covid from genbank & will give output of a string containing 29,900 characters (that we can actually see by clicking on the EBI website below)

it is use a function called "getSequence" with code:
```python
def getSequence(entryId, dbName = 'uniprotkb', alphabet = Protein_Alphabet, format = 'fasta', debug: bool = True):

    if not isinstance(entryId, str):
        entryId = entryId.decode("utf-8")

    url ='http://www.ebi.ac.uk/Tools/dbfetch/dbfetch? style=raw&db=' + dbName + '&format=' + format + '&id=' + entryId

    try:
        if debug:
            print('DEBUG: Querying URL: {0}'.format(url))

        data = urllib.request.urlopen(url).read()
        if format == 'fasta':
            return readFastaString(data.decode("utf-8"), alphabet)[0]

        else:
            return data.decode("utf-8")

    except urllib.error.HTTPError as ex:
        raise RuntimeError(ex.read())
        
#This function retrieves a single entry from a database (entryId: ID for entry e.g.'MN908947', dbName: name of database e.g. 'genbank')
```

once we got that DNA string (consisting of only 4 types of characters-A/C/T/G), a biologist will translate them (into AminoAcid or Protein string, consisting 20 types of characters + asterisk/* , please see https://www.hgvs.org/mutnomen/codon.html). We'll translate them using a dictionary (code not shown) and then we'll split them based on * so that we can generate an output of a list of strings that is stored in a variable called "protseq" (see https://docs.google.com/document/d/1R22IGMfe9i1tYAlPK5ZSOikV-ON6xZVUq-C87xDMiLg/edit?usp=sharing )

finally, from that I need to find how many strings inside of that "protseq" that meet these criteria:
1) start with M
2) end with *
3) has length of >=100 characters

so, my question is actually:
how to understand the logic behind the below code that is said to be able to do that job:

```python
#check first occurence of M in each string of that 'protseq' list

where_M_in_protseq_1st-string = protseq[0].find('M')
print(where_M_in_protseq_1st-string)
print(len(protseq[0]))

#code to check whether each string in that 'protseq' start with M and >= 100
cnt = 0

for i in protseq:
    if len(i) - i.find("M") >= 100:
        cnt +=1

print(cnt)
        
for seq in protseq:
    m_pos = seq.find("M")  
    m_end_seq = seq[m_pos:]

    if len(m_end_seq) > 100:
        print(m_end_seq)
        print(len(m_end_seq))    
```

The answer for this problem should be 8 strings inside 18 members of that protseq list will meet that criteria (so if we can end up getting 8 from that code we are correct)--> (but I just hope that I can get it correct and understand how the code works)

Importance: from that 8 strings, we can try 1 of them in a real protein database (called Uniprot-KB) and know what part of covid body that is likely to interact with human and causing disease

Thank you very much

#### Answers

```python
import urllib

class Alphabet():
    """ A minimal class for alphabets
        Alphabets include DNA, RNA and Protein """
    def __init__(self, symbolString):
        self.symbols = symbolString
    def __len__(self):              # implements the "len" operator, e.g. "len(Alphabet('XYZ'))" results in 3
        return len(self.symbols)    # will tell you the length of the symbols in an Alphabet instance
    def __contains__(self, sym):    # implements the "in" operator, e.g. "'A' in Alphabet('ACGT')" results in True
        return sym in self.symbols  # will tell you if 'A' is in the symbols in an Alphabet instance
    def __iter__(self):             # method that allows us to iterate over all symbols, e.g. "for sym in Alphabet('ACGT'): print sym" prints A, C, G and T on separate lines
        tsyms = tuple(self.symbols)
        return tsyms.__iter__()
    def __getitem__(self, ndx):
        """ Retrieve the symbol(s) at the specified index (or slice of indices) """
        return self.symbols[ndx]
    def index(self, sym):
        """ Retrieve the index of the given symbol in the alphabet. """
        return self.symbols.index(sym)
    def __str__(self):
        return self.symbols

""" Below we declare alphabet variables that are going to be available when
this module (this .py file) is imported """
DNA_Alphabet = Alphabet('ACGT')
RNA_Alphabet = Alphabet('ACGU')
Protein_Alphabet = Alphabet('ACDEFGHIKLMNPQRSTVWY')
Protein_wX = Alphabet('ACDEFGHIKLMNPQRSTVWYX')
Protein_wGAP = Alphabet('ACDEFGHIKLMNPQRSTVWY-')


def getSequence(entryId, dbName = 'uniprotkb', alphabet = Protein_Alphabet, format = 'fasta', debug: bool = True):
    """ Retrieve a single entry from a database
    entryId: ID for entry e.g. 'P63166' or 'SUMO1_MOUSE'
    dbName: name of database e.g. 'uniprotkb' or 'pdb' or 'refseqn'; see http://www.ebi.ac.uk/Tools/dbfetch/dbfetch/dbfetch.databases for available databases
    format: file format specific to database e.g. 'fasta' or 'uniprot' for uniprotkb (see http://www.ebi.ac.uk/Tools/dbfetch/dbfetch/dbfetch.databases)
    See http://www.ebi.ac.uk/Tools/dbfetch/syntax.jsp for more info re URL syntax
    """
    if not isinstance(entryId, str):
        entryId = entryId.decode("utf-8")
    url ='http://www.ebi.ac.uk/Tools/dbfetch/dbfetch?style=raw&db=' + dbName + '&format=' + format + '&id=' + entryId
    try:
        if debug:
            print('DEBUG: Querying URL: {0}'.format(url))
        data = urllib.request.urlopen(url).read()
        if format == 'fasta':
            return readFastaString(data.decode("utf-8"), alphabet)[0]
        else:
            return data.decode("utf-8")
    except urllib.error.HTTPError as ex:
        raise RuntimeError(ex.read())


# get the covid 19 genome (29kB)
covid_seq = getSequence('MN908947', 'genbank', DNA_Alphabet)
# print(seq_no10)

# get all the bases from covid_seq
# translate all of those base into amino acid seq
# in all reading frames (6)





tr_f = [0, 1, 2]
# translate protein
covid_AAseq = []

for i in tr_f:
    #print("all ORF in fwd direction", covid_seq.translateDNA(i, True))
    seq10b=covid_seq.translateDNA(i, True)
    protseq=seq10b.split("*")
    seq10br = covid_seq.translateDNA(i, False)
    protseq.extend(seq10br.split("*"))
print(str(protseq))
#     print(protseq)
#     for element in protseq:
#         print("Individual value is",element)
# #for i in tr_f:
#     print("all ORF in reverse direction", covid_seq.translateDNA(i, False))
    
#NEXT STEP (for mapping the ORF that begins with M & calculate the len > 100)
ORF = []
for i in protseq:
    if i.startswith('M') == True:
        ORF.append(i)
print('all of potential ORF', ORF)

print('length of all potential ORF')
for i in ORF:
    print(i, ":", len(i))

true_ORF = []
for i in ORF:
    if len(i) > 100:
        true_ORF.append(i)
print(true_ORF)

# for i in protseq:
#     if i == 'M': # and len(i) > 100:
#         ORF.append(i)
# print(ORF)       
 

```


```python
characters = "asjidowgeriogpjicnjjlaksdjalksdj*alskjdjjjjeosj   hjjjjl"

# We want to pick out "jid" and "jic"
ans = []
for k, c in enumerate(characters):
    if c == "j":   # add abtrary number of constraints
        ans.append(characters[k:k+3])
    if c == "*":
        break

if len(ans[-1]) < 3:
    ans.pop()
        
print(ans)
```


```python
characters = "asjidowgeriogpjicneosjl"
```
