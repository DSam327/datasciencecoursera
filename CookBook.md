The dataset was generated from experiments involving 30 volunteers aged between 19 and 48 years. Each participant performed six distinct activities (such as WALKING, SITTING, STANDING, etc.) while wearing a Samsung Galaxy S II smartphone on their waist. The phone's accelerometer and gyroscope sensors recorded 3D linear acceleration and angular velocity at a frequency of 50Hz. These activities were manually labeled based on video recordings. The dataset was split randomly, with 70% of the participants used for training and 30% for testing.

Prior to analysis, sensor data underwent noise reduction and was processed using sliding windows of 2.56 seconds with a 50% overlap, resulting in 128 samples per window. A low-pass Butterworth filter, with a cutoff frequency of 0.3 Hz, separated the acceleration signals into body and gravitational components. Each window of data was transformed into a feature vector, incorporating both time and frequency domain variables.

For every data record, the following information is included:

Three-axis acceleration from both the accelerometer and the estimated body movement.
Three-axis angular velocity data from the gyroscope.
A 561-feature vector derived from both time and frequency domains.
The label corresponding to the activity performed.
An identifier for the subject who participated in the experiment.
