--Number of providers that offered services in 2011
SELECT COUNT(DISTINCT provider_id) FROM bigquery-public-data.medicare.inpatient_charges_2011;
--Total discharges for each provider sorted in descending order
SELECT provider_name, SUM(total_discharges) AS total_discharges FROM bigquery-public-data.medicare.inpatient_charges_2011 GROUP BY provider_name ORDER BY total_discharges DESC;
--Top 10 provider cities with the highest average medicare payments
SELECT provider_city, SUM(average_medicare_payments) AS total_medicare_payments FROM bigquery-public-data.medicare.inpatient_charges_2011 GROUP BY provider_city ORDER BY total_medicare_payments DESC LIMIT 10;
--Total average medicare payments for each provider
SELECT provider_name, SUM(average_medicare_payments) AS total_payments FROM bigquery-public-data.medicare.inpatient_charges_2011 GROUP BY provider_name ORDER BY total_payments;
/*Total discharges into categories; 100 and above as High, 50-99 as Medium, and 49 and below as Low*/
SELECT provider_name, provider_city, total_discharges,
CASE
  WHEN total_discharges >= 100 THEN "High"
  WHEN total_discharges < 100 AND total_discharges >= 50
  THEN "Medium"
  ELSE "Low" END AS Discharge_flag
FROM bigquery-public-data.medicare.inpatient_charges_2011;
/*comparing the total charges of providers that offered services in 2011 and 2012*/
SELECT m11.provider_name, SUM(m11.total_discharges), m12.provider_name, SUM(m12.total_discharges) FROM bigquery-public-data.medicare.inpatient_charges_2011 AS m11 JOIN bigquery-public-data.medicare.inpatient_charges_2012 AS m12 ON m11.provider_id=m12.provider_id GROUP BY m11.provider_name, m12.provider_name;
--List of providers that provided services in 2011 and 2012
SELECT DISTINCT a.provider_name, b.provider_name FROM bigquery-public-data.medicare.inpatient_charges_2011 a JOIN bigquery-public-data.medicare.inpatient_charges_2012 b ON a.provider_id=b.provider_id;
--List of providers that offered services in 2011 but not in 2012
SELECT DISTINCT y.provider_name, z.provider_name FROM bigquery-public-data.medicare.inpatient_charges_2011 AS y LEFT JOIN bigquery-public-data.medicare.inpatient_charges_2012 AS Z ON y.provider_id=z.provider_id WHERE z.provider_name IS NULL
--Total discharges for each provider accross the 4 years
SELECT a.provider_name, SUM(a.total_discharges) AS total_discharges_2011, SUM(b.total_discharges) AS total_discharges_2012, SUM(c.total_discharges) AS total_discharges_2013, SUM(d.total_discharges) AS total_discharges_2014 FROM bigquery-public-data.medicare.inpatient_charges_2011 a JOIN bigquery-public-data.medicare.inpatient_charges_2012 b ON a.provider_id=b.provider_id JOIN bigquery-public-data.medicare.inpatient_charges_2013 c ON a.provider_id=c.provider_id JOIN bigquery-public-data.medicare.inpatient_charges_2014 d ON a.provider_id=d.provider_id GROUP BY a.provider_name;
--Merging 2011 and 2012 tables
SELECT * FROM bigquery-public-data.medicare.inpatient_charges_2011
UNION ALL
SELECT * FROM bigquery-public-data.medicare.inpatient_charges_2012


