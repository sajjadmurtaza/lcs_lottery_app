# lcs_lottery_app

Ruby Version: 3.0.0

Rails Version: 7.0.1

*  lcs_lottery_app is a web application for managing lottery results. 
It allows users to upload CSV files with participant data, calculate winnings based on winning numbers, and provides a user-friendly interface for viewing and downloading results.

* You can also calculate winnings using rake task ```rake 'lottery:generate_winners[CSV_FILE_PATH,WINNING_NUMMBER]``` 
e.g. ```rake 'lottery:generate_winners[participants.csv,456000123]``` 


### Key files

    
    app
    ├── controller                     
    │      └── lottery_controller  
    │
    |
    ├── services
    |      ├── lottery_processor
    |      └── lcs_calculator
    |
    └──  views
    │      └── lottery (_csv_file_list, winners_table, _form, index)
    │
    |
    ├── lib/taks
    |       └── lottery
    |
    └── specs
            ├── controller -> lottery_controller_spec
            ├── services -> lottery_processor_spec, lcs_calculator_spec
            └── lb/tasks -> lottery
    

### Workflow - How does it work?


* Upload CSV Files:

On the home page of the Lottery Project web application, locate the "Upload CSV File" section.
Click on the "Choose File" button to select a CSV file containing participant data.
Enter the winning number in the "Winning Number" input field.
Click the "Calculate Winnings" button to submit the form.

* Processing CSV Data:

After submitting the form, the application will process the uploaded CSV file using the provided winning number.
It will calculate the winnings for each participant based on their ticket numbers.

* Viewing Winners:

If there are winners, you will be directed to a results page.
On this page, you will see a table titled "Winners" displaying the participants who won and their respective credits.
The table will include columns such as "Participant" and "Credits."

* Downloading CSV Files:

The application provides a section for downloading CSV files.
It lists previously generated CSV files.
You can click on a file name to download it.

* Command Line (Rake Task):

If you prefer to use the command line, you can use the Rake task provided by the Lottery Project.
Open your terminal and navigate to the root directory of your Rails project.

* Using Rake Task (generate_winners):

Run the Rake task using the following command:
```
    rails lottery:generate_winners[csv_file_path,winning_number]
```
Replace csv_file_path with the path to your CSV file.
Replace winning_number with the winning number for the lottery.

* Rake Task Output:

The Rake task will process the specified CSV file and winning number.
It will print the list of winners and their credits to the console.
* 
No Results Message:

If no participants in the CSV file match the winning number, the application will display a message indicating that no winners were found.

![alt text](https://raw.githubusercontent.com/sajjadmurtaza/SchedulyBridge/master/app/assets/images/l.png "res Screenshot")


**Setup**

* first clone the directory 
                      ```
                      git clone git@github.com:sajjadmurtaza/lcs_lottery_app.git
                      ```
 *  ```cd lcs_lottery_app```

 *  ```bundle install ```

 *  ```rails s ```


AND
```rails lottery:generate_winners[csv_file_path,winning_number]```
 
 ***


### Specs

run ``` bundle exe rspec   ``` to run the tests

#### Note
This project support command-line also web base calculate winnings based on winning numbers.