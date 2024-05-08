--Created by: group6(S322)
--Assignment2, Apr 5 2024
-- Cleanup for assign2
--run as 'sys as sysdba'

DROP USER group6 CASCADE;
DROP ROLE labAdmin;
DROP TABLESPACE assign2 INCLUDING CONTENTS AND DATAFILES;

-- End of File