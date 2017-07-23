
    # Read Me 

    ## User Details
    Name:   Irwin Cassells
    Date:   21 July 2017
    Type:   Source material
    
    ## Programme Flow
    
    ### Programme Stages and Functions
    The programme exists of 4 main stages of running. Each stage of the programme runs to perform generally a specific function. The following is a list of all the stages and
    their purpose of the stage:

    * __Stage 1: Import Data__. This part of the code serves to only import the data. A minor manipulation is done here to force coercion to a data.frame type. This is solely for 
                                preferential reasons. 

    * __Stage 2: Reduce Data Size__. The overall aim of this stage is to reduce the larger sets to smaller sets or to use them and remove them from memory. A list of all the indices
                                     where mean and std are found is collected (with their names) from the features table. This is then used to create a data frame for the test
                                     and training sets which only have these values. The names of these columns are changed using regular expressions (see code). Lastly unused frames
                                     are deleted. 

    * __Stage 3: Merge Sets__.  This stage seeks to eliminate the separation of test and training sets. A join was used to preserve row order (which is not the case with merge) and 
                                the subjects and activity sets were joined (using a cbind command) onto these sets to create a full data set. As before, removal of the unused sets
                                was implemented again. 

    * __Stage 4: Second Data Set__. This stage produces a second set that contains the averages of each field. The dpylr package was used for this, using group_by and summarise_all. 
                                    Files were written to .csv before they are removed from memory. 
    
    ### Data Set Manipulations
    The programme seeks to end with 2 tidy data sets. The following is an explanation of the method (logic) the code follows:

    * The train and test (X,Y and Sub) sets are loaded into R with the features and activity list. 
    * From the features table, indices of where the mean and std was retrieved and the X sets were reduced using these indices. 
    * The column names were retrieved from the features table a manipulated. Note that names have a textTextText format to them for easy reading.
    * This subject and actvity sets were joined to X sets and finally combined to create the first final set.
    * Using the dplyr package, the second was created grouping on each subject and then each activity. 
    
    
    ## Addtional Notes

    * Code is written with '=' and not '<-'
    * File structure should be folders (test,train) and files (activity.txt, features.txt). 
    
    # ------------------------------------------------------------------------------------------------------------------------------------------------------------------------
    ## Changes
    
    ## User Details
    Name:
    Date:
    Type:   Modifications

    ### List of Changes
    The following is a list of all changes made to the programme:

    * _insert here_
    

    
