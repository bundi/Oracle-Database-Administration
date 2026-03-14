-------------------------------------------------------------------------------------

-- Doing hot backup
-- database must be in archive log mode
-- check archive mode
archive log list

-- find location of datafiles
select file_name from dba_data_files;

-- location of control files
select name from v$controlfile;

-- find current log sequence number
select group#, sequence#, status from v$log;

-- put database in backup mode
alter database begin backup;

-- Ensure all the datafiles are in backup mode

select file#, status frombackup


--open new terminal
cd /
mkdir hotbackup
-- navigate to the files drectories
cp -r data /hotbackup/
cp -r control /hotbackup/
cp -r arch /hotbackup/

cd /
cd hotbackup
ls


-- go back to the database
alter database end backup;

-- ensure files are not in active mode
select file#, status from v$backup;

-- archive the current log file
alter system archive log current;

-- confirm current sequence number
select group#, sequence#, status from v$log;


--backup control file
alter database backup controlfile to '/hotbackup/control.bk';

--In Linux terminal
chown oracle hotbackup

--backup again the control file
alter database backup controlfile to '/hotbackup/control.bk';


-- backup the archive log file
cd to arch directory
c
-- copy the archive log file to hotbackup
cp <logfile_name> to /hotbackup/
