Feature: Robust Gaussian Fitting

  As a user of the GaussianFitter
  I want the fitting process to handle invalid parameter candidates (e.g., negative sigma) gracefully
  So that I can successfully fit models even when the optimizer explores forbidden regions

  Scenario: Fitting a Gaussian model with data triggering negative sigma exploration
    Given a GaussianFitter initialized with a LevenbergMarquardtOptimizer
    And the following observed data points:
      | 0  | 1.1143831578403364E-29 |
      | 1  | 4.95281403484594E-28   |
      | 2  | 1.1171347211930288E-26 |
      | 3  | 1.7044813962636277E-25 |
      | 4  | 1.9784716574832164E-24 |
      | 5  | 1.8630236407866774E-23 |
      | 6  | 1.4820532905097742E-22 |
      | 7  | 1.0241963854632831E-21 |
      | 8  | 6.275077366673128E-21  |
      | 9  | 3.461808994532493E-20  |
      | 10 | 1.7407124684715706E-19 |
      | 11 | 8.056687953553974E-19  |
      | 12 | 3.460193945992071E-18  |
      | 13 | 1.3883326374011525E-17 |
      | 14 | 5.233894983671116E-17  |
      | 15 | 1.8630791465263745E-16 |
      | 16 | 6.288759227922111E-16  |
      | 17 | 2.0204433920597856E-15 |
      | 18 | 6.198768938576155E-15  |
      | 19 | 1.821419346860626E-14  |
      | 20 | 5.139176445538471E-14  |
      | 21 | 1.3956427429045787E-13 |
      | 22 | 3.655705706448139E-13  |
      | 23 | 9.253753324779779E-13  |
      | 24 | 2.267636001476696E-12  |
      | 25 | 5.3880460095836855E-12  |
      | 26 | 1.2431632654852931E-11 |
    When I fit the model to the data
    Then the fitting process should complete without throwing exceptions
    And the estimated mean parameter should be approximately 53.1572792
    And the estimated sigma parameter should be approximately 5.75214622
