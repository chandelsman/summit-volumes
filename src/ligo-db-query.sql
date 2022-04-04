USE [LIGOLAB_37_SUMMIT]
SELECT
lo.ACCESSION AS 'Accession',
lotr.LAB_TEST_RESULT_ACCESSION AS 'Result ID',
c.CLIENT_REFERENCE_ID AS 'Client ID',
c.NAME AS 'Client Name',
CONCAT(lp.LAST_NAME, ', ', lp.FIRST_NAME) AS 'Patient Name',
lo.GROUP_PATIENT_ID AS 'Patient ID',
lp.DOB AS 'Date of Birth',
lotr.CREATED_TIMESTAMP AS 'Result Created Time', -- could use this or preceeding line???
  -- lotr.COMPLETED_TIME AS 'Report Released Time', -- line below returns proper released time
lor.RELEASED_TIME AS 'Report Released Time',
lotrcpt.CPT_CODE AS 'GUID',
mcpt.CODE AS 'CPT Code',
lotrcpt.QUANTITY AS 'Quantity',
lotrcpt.CREATED_TIMESTAMP AS 'CPT Created Time'
FROM
LAB_ORDER lo
INNER JOIN LAB_ORDER_TEST_RESULT lotr ON lotr.LAB_ORDER_ID = lo.LAB_ORDER_ID
INNER JOIN CLIENT c ON lo.CLIENT_ID = c.CLIENT_ID
INNER JOIN LAB_PATIENT lp on lp.LAB_PATIENT_ID = lo.LAB_PATIENT_ID
INNER JOIN LAB_ORDER_TEST_RESULT_CPT lotrcpt ON lotrcpt.LAB_ORDER_TEST_RESULT_ID = lotr.LAB_ORDER_TEST_RESULT_ID
INNER JOIN LAB_ORDER_REPORT lor on lor.LAB_ORDER_REPORT_ID = lotr.LAB_ORDER_REPORT_ID
INNER JOIN MASTER_CPT_CODE mcpt ON mcpt.CPT_CODE = lotrcpt.CPT_CODE
WHERE
-- lotr.COMPLETED_TIME BETWEEN '2020-12-28 00:00:00.001' AND '2021-01-27 23:59:59.999'
lor.RELEASED_TIME BETWEEN '2015-01-01 00:00:00.001' AND '2022-03-27 23:59:59.999'
-- AND ACCESSION = '12175860' -- check that this autopsy is present for PVH
-- Below OR and AND statements pull cytology reads for Regional West
OR c.CLIENT_REFERENCE_ID = '9586214' -- Regional West Medical Center
AND lotr.CREATED_TIMESTAMP BETWEEN '2022-02-28 00:00:00.001' AND '2022-03-27 23:59:59.999'
ORDER BY
lotr.CREATED_TIMESTAMP
GO
