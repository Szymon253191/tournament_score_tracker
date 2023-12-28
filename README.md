# Tournament Score Tracker

## Written in C#/.NET program designed to help you run tournaments.
This program can help you by: 
* creating ladders, 
* saving results, 
* creating PDF with current results,  
* informing participants by email

Technologies used: MS SQL, SSMS, Visual Studio, Dapper, Windows Forms, iText7. Database for application is stored in SQL Server. Allows user to add memebers and team, create prize and manage matchups created into single elimination brackets sorted randomly.

___

## Instruction
The first window you will encounter allows you to choose whether to create a tournament or continue an existing one. The path from creating a tournament will be shown, but if you want to know how to control a previously created tournament, go to [Tournament Viewer](#tournament-viewer) section
### Tournament Dashboard
<p align="center">
  <img src=https://user-images.githubusercontent.com/62205129/232327969-1fa9be4c-a771-4c80-b280-f59aedbf358b.jpg>
</p>

After <strong>Create Tournament</strong> button click the folowing window will appear:

### Create new tournament
<p align="center">
  <img src=https://user-images.githubusercontent.com/62205129/232328744-26a1e7df-4738-4637-9505-828b4a9b03f9.jpg>
</p>

Here you can:
- name your tournament,
- select entry fee,
- add (or create) new teams
- create prize for tournament.

### Create new team
If you want to create new team - click [create new](###) link. 
There you can:
- name your team,
- add members to team
- create new members in database

<p align="center">
  <img src=https://user-images.githubusercontent.com/62205129/232328978-ff08d8fe-268f-48e7-b6fc-9f46f1678022.jpg>
</p>

After everything is done click <strong>Create Tournament</strong> button.

___

## Tournament Viewer
After selecting <strong>Create Tournament</strong> a new window will appear. 

<p align="center">
  <img src=https://user-images.githubusercontent.com/62205129/232329944-7b525356-5a93-4186-945d-f3f77600d94f.jpg>
</p>

Here you can see matchups for each round and if they are ready to play, played or having bye first round. Here you can select score for each match and if all matches are finished next round will be created.
Scoring has two rules:
1. Score must be integer greater or equal to 0.
2. Score can't be the same for both teams (no draws allowed).

You can check <strong>Unplayed only</strong> to hide played matches and those having bye.

## PDF File with bracket
Button <strong>Save PDF</strong> creates a pdf file containing the ladder and the results current at the time of the click. Example image of file below:

<p align="center">
  <img src=https://user-images.githubusercontent.com/62205129/232330279-fe5a8b3b-f2a2-40c5-9d70-611e4ca9d33e.jpg>
</p>

## E-mails to participants
With each round being created, each team member will recive an e-mail with inforamtion who will be next competitor and at the end all tournament all players will recive email notifying who won the tournament.

<p align="center">
  <img src=https://user-images.githubusercontent.com/62205129/232330522-decae668-ae64-426e-a828-c00db843d59f.jpg>
</p>

Also at the end tournament is set to be inactive and will not appear in tournament selection in Tournament Dashboard

___

## How to tweak this project

### Changing file path for all created files
Change key value in ```<appSettings>```:
```
<appSettings>
  <add key="filePath" value="C:\Users\Me\MyFolder\tournament_score_tracker\TextDataBase" />
</appSettings>
```

### Sending E-mailing via network 
If you want to use e-mailing function with f.e. Gmail you need to change ```App.config``` file:
```
<system.net>
  <mailSettings>
    <smtp deliveryMethod="Network">
      <network host="127.0.0.1" port="25" enableSsl="false" />
    </smtp>
  </mailSettings>
</system.net>
```
Here you need to change host, port, add userName and password.

Also change these values in ```<appSettings>```:
```
<appSettings>
  <add key="senderEmail" value="TST@mail.com" />
  <add key="senderDisplayName" value="Tournament Operator" />
</appSettings>
```

### Changing SQL databse
Remember to change ```<connectionString>``` in ```App.config``` file. To use it localy with SQ: Server try this syntax:
```
<connectionStrings>
  <add name="MyDatabaseName" connectionString="Server=DESKTOP-XXXXXXX;Database=YOUR_DB_NAME;Trusted_Connection=True;" providerName="System.Data.SqlClient" />
</connectionStrings>
```

___

## Known issues:
- [ ] Not using path key to create location for PDF folder/files
- [ ] If opened from scratch winner in byes matchup is not assigned for next round match

## Find a bug?

If you found an issue or would like to submit an improvement to this project please submit an issue using issues tab above. 
