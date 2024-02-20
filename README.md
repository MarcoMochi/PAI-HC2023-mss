Installation instructions for different Operating Systems building from sources or using Anaconda for Clingo v5.4.0 can be found here: https://github.com/potassco/clingo/blob/master/INSTALL.md, https://potassco.org/clingo/, https://github.com/potassco/clingo/releases/tag/v5.4.0

There are 3 main folders, one for the scheduling of the different scenarios based on generated data, one for the scheduling with the real data, and one for the rescheduling of the different scenarios.

Inside the scheduling folder there are 4 subfolders, each corresponding to one Scenario, and the encoder.
In each folder there are 10 instances.

To run the file you can execute the following command:
./clingo Scenario N/FILENAME.lp encoding.lp --opt-strategy=usc --parallel-mode 6
To change the number of days or sessions you can execute the following command:
./clingo Scenario N/FILENAME.lp encoding.lp --opt-strategy=usc --parallel-mode 6 --const s_max=n --const d_count=m

Inside the real_data folder there are:
- the new encoding to generate a better MSS starting from real data: new_encoding.lp.
- the input file with the original target value: original.lp, to use with the original encoding
- the new input file with the derived new target value new_percentage.lp, to use with the new encoding

Inside the rescheduling folder there are 3 subfolders, each corresponding to one Scenario, and the encoder.
In each folder there are 4 instances of increasing difficulty.

To run the file you can execute the following command:
./clingo scN/inputM.lp encoding.lp --parallel-mode 6
