
    # Code book

    ## Prefix and Suffix notation
    ### Prefix
    * t: Time domain
    * f: Frequency domain

    ### Suffix
    * XYZ : Coordinate axis direction
    * Mean: Mean value
    * STD : Standard deviation value

    ## Base Variable list

    1.  Subject
            Integer: Number of subject
    2.  Activity
            String: List of activity 
    3.  tAcceleration
            Double: Total horizontal acceleration in the X,Y,Z direction (time domain)
    4.  tGravityAcceleration
            Double: Total vertical acceleration (time domain)
    5.  tAccelerationJerk
            Double: Total change of acceleration per single unit of time in X,Y,Z direction (time domain)
    6.  tGyroscope
            Double: Total gyroscopic force in X,Y,Z direction (time domain)
    7.  tGyroscopeJerk
            Double: Total change of gyroscopic force in X,Y,Z direction per unit time (time domain)
    8.  tAccelerationMag
            Double: Magnitude of total horizontal acceleration (time domain)
    9.  tGravityAccelerationMag
            Double: Magnitude of total vertical acceleration (time domain)
    10. tAccelerationJerkMag
            Double: Magnitude of total change of acceleration (time domain)
    11. tGyroscopeMag
            Double: Magnitude of total gyroscopic force (time domain)
    12. tGyroscopeJerkMag
            Double: Magnitude of total change of gyroscopic force (time domain)
    13. fAcceleration
            Double: Total horizontal acceleration in the X,Y,Z direction (frequency domain)
    14. fAccelerationFrequency
            Double: Total vertical frequency acceleration (frequency domain)
    15. fAccelerationJerk
            Double: Total change of acceleration per single unit of time in X,Y,Z direction (frequency domain)
    16. fAccelerationJerkFrequency
            Double: Total change of frequency acceleration per single unit of time in X,Y,Z direction (frequency domain)
    17. fGyroscope
            Double: Total gyroscopic force in X,Y,Z direction (frequency domain)
    18. fGyroscopeFrequency
            Double: Total frequncy gyroscopic force in X,Y,Z direction (frequency domain)
    19. fAccelerationMag
            Double: Magnitude of total horizontal acceleration (frequency domain)
    20. fAccelerationMagFrequency
            Double: Magnitude of total horizontal frequency acceleration (frequency domain)
    21. fAccelerationJerkMag
            Double: Magnitude of total change of acceleration (frequency domain)
    22. fAccelerationJerkMagFrequency
            Double: Magnitude of total change of frequency acceleration (frequency domain)
    23. fGyroscopeMag
            Double: Magnitude of total gyroscopic force (frequency domain)
    24. fGyroscopeMagFrequency
            Double: Magnitude of total frequency gyroscopic force (frequency domain)
    25. fGyroscopeJerkMag
            Double: Magnitude of total change of gyroscopic force (frequency domain)
    26. fGyroscopeJerkMagFrequency
            Double: Magnitude of total change of frequency gyroscopic force (frequency domain)
    27. AngularAccelerationGravity
            Double: Angular momentum due to gravitational force
    28. AngularAccelerationJerkGravity
            Double: Change of angular momentum due to gravitational force
    29. AngularGyroscopeGravity
            Double: Gyroscopic force due to gravitional force
    30. AngularGyroscopeJerkGravity
            Double: Change of gyroscopic force with respect to unit time due to gravitional force
    31. AngularXGravity
            Double: Angular velocity in the X-direction
    32. AngularYGravity
            Double: Angular velocity in the Y-direction
    33. AngularZGravity
            Double: Angular velocity in the Z-direction
    
    ## Unit lists
    All variable units using the following in description:
    * Force: kg.m.s^(-2)
    * Acceleration: m.s^(-2)
    * Jerk: m.s^(-3)
    * Velocity: m.s^(-1)
    
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
    * Information about changes and the programme flow is found in README.md
    
    
