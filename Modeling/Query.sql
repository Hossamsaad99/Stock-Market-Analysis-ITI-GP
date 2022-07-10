-- DESKTOP-OI0D7R8
-- Index Daily Monitoring Dashboard

SELECT *
	INTO D1_Index
	FROM (
		SELECT [Date],ROUND([high],4)as"high",ROUND([Low],4)as"Low",ROUND([open],4) as "Open",ROUND([Close],4) "CLose",[volume],
			ROUND(COALESCE(LAG([Close]) over (order by [DATE] ASC),[Close]),4) as Previous_close,
			COALESCE(LAG([volume]) over (order by [DATE] ASC),[volume]) as Previous_Volume,
			ROUND([Close] - COALESCE(LAG([Close]) over (order by [DATE] ASC),[Close]),4) as CHANGE,
			ROUND(([Close] - COALESCE(LAG([Close]) over (order by [DATE] ASC),[Close]))/ COALESCE(LAG([Close]) over (order by [DATE] ASC),[Close]),4)*100  as "%Change",
			ROUND([Close] - COALESCE(LAG([Close],7) over (order by [DATE] ASC),[Close]),4) as Past_7_days,
			[Close] - COALESCE(LAG([Close],30) over (order by [DATE] ASC),[Close]) as Past_30_days,
			ROUND(([Close] - COALESCE(LAG([Close],7) over (order by [DATE] ASC),[Close]))/COALESCE(LAG([Close],7) over (order by [DATE] ASC),[Close]),4)*100 as Performance_7_days,
			ROUND(([Close] - COALESCE(LAG([Close],30) over (order by [DATE] ASC),[Close]))/COALESCE(LAG([Close],30) over (order by [DATE] ASC),[Close]),4)*100 as Performance_30_days,
			ROUND(MAX([High]) over (order by [DATE]  ROWS BETWEEN 252 PRECEDING AND CURRENT ROW),2) as "52_week_high",
			ROUND(MIN([Low]) over (order by [DATE]  ROWS BETWEEN 252 PRECEDING AND CURRENT ROW),2) as "52_week_low"
			from dbo.[fact_s&p_historic]
		) q1

select top 5 * 
from D1_Index
order by date desc;
-------------------------------------------------------------
-- TOP High and Low with 10

SELECT * 
INTO D1_Top_worest_days
FROM(
	SELECT * 
	FROM(
		SELECT  TOP 10 
		[Date] ,round([high],4) as "high" , round([Low],4) as "Low" ,round([open],4) as "Open",round([Close],4) "CLose",
		round(([Close] - coalesce(lag([Close]) OVER (ORDER BY [Date] ASC),[Close]))/ coalesce(lag([Close]) OVER (ORDER BY [Date] ASC),[Close]),4)*100  as "%Change"
		FROM [fact_s&p_historic]
		ORDER BY 6 DESC) Top_10_days

UNION

	SELECT * 
	FROM (
		SELECT  TOP 10
		[Date] ,round([high],4) as "high" , round([Low],4) as "Low" ,round([open],4) as "Open",round([Close],4) "CLose",
		round(([Close] - coalesce(lag([Close]) OVER (ORDER BY [Date] ASC),[Close]))/ coalesce(lag([Close]) OVER (ORDER BY [Date] ASC),[Close]),4)*100  as "%Change"
		FROM [fact_s&p_historic]
		ORDER BY 6 ASC) Worest_10_days
	) q2

SELECT top 5 * 
FROM D1_Top_worest_days
order by date desc;
----------------------------------------------------------------------------------
-- Volatily KPIs

CREATE VIEW Top_Sectors_Volatily
AS
WITH Sector_info 
	AS(
		SELECT S.sector , D.Date, Sum(D."Close") AS "Close"
		FROM dbo.company_sector_dim S 
		INNER JOIN dbo.company_info_dim I 
		ON I.company_sector_dim_index = S."Index"
		INNER JOIN  dbo.fact_daily_monitoring D
		ON I.Symbol = D.Symbol
		GROUP BY  S.sector , D.Date
		)
SELECT * ,
	([Close] - lag([Close]) OVER (PARTITION BY sector ORDER BY [Date] ASC))/ lag([Close]) OVER (PARTITION BY sector ORDER BY [Date] ASC)*100 as "%Change"
FROM Sector_info;

SELECT *, 
	STDEV([%Change]) over(partition by sector ,Year([Date]) order by [Date]  asc  rows between unbounded preceding and unbounded following) as daily_STD,
	Sqrt(5)* STDEV([%Change]) over(partition by sector,Year([Date]) order by [Date]  asc  rows between unbounded preceding and unbounded following) as Weekly_volatily,
	Sqrt(252)* STDEV([%Change]) over(partition by sector , Year([Date]) order by [Date]  asc  rows between unbounded preceding and unbounded following) as yearly_volatily

	INTO D1_Volatily_Measures
	FROM Top_Sectors_Volatily
	ORDER BY sector , Date 


SELECT top 5 * 
FROM D1_Volatily_Measures
order by date desc;
------------------------


SELECT *
	INTO D2_Daily
	FROM (
		SELECT [Date], [Symbol] , ROUND([high],4)as"high",ROUND([Low],4)as"Low",ROUND([open],4) as "Open",ROUND([Close],4) "CLose",[volume],

			ROUND(COALESCE(LAG([Close]) over (partition by Symbol order by [DATE] ASC),[Close]),4) as Previous_close,
			COALESCE(LAG([volume]) over (partition by Symbol order by [DATE] ASC),[volume]) as Previous_Volume,
			ROUND([Close] - COALESCE(LAG([Close]) over (partition by Symbol order by [DATE] ASC),[Close]),4) as CHANGE,
			ROUND(([Close] - COALESCE(LAG([Close]) over (partition by Symbol order by [DATE] ASC),[Close]))/ COALESCE(LAG([Close]) over (order by [DATE] ASC),[Close]),4)*100  as "%Change",
			ROUND([Close] - COALESCE(LAG([Close],7) over (partition by Symbol order by [DATE] ASC),[Close]),4) as Past_7_days,
			[Close] - COALESCE(LAG([Close],30) over (partition by Symbol order by [DATE] ASC),[Close]) as Past_30_days,
			ROUND(([Close] - COALESCE(LAG([Close],7) over (partition by Symbol order by [DATE] ASC),[Close]))/COALESCE(LAG([Close],7) over (order by [DATE] ASC),[Close]),4)*100 as Performance_7_days,
			ROUND(([Close] - COALESCE(LAG([Close],30) over (partition by Symbol order by [DATE] ASC),[Close]))/COALESCE(LAG([Close],30) over (order by [DATE] ASC),[Close]),4)*100 as Performance_30_days,
			ROUND(MAX([High]) over (partition by Symbol order by [DATE]  ROWS BETWEEN 252 PRECEDING AND CURRENT ROW),2) as "52_week_high",
			ROUND(MIN([Low]) over (partition by Symbol order by [DATE]  ROWS BETWEEN 252 PRECEDING AND CURRENT ROW),2) as "52_week_low",
			ROUND([Close] - COALESCE(LAG([Close],252) over (partition by Symbol order by [DATE] ASC),[Close]),4) as YTD_Close
			from dbo.fact_daily_monitoring
			
		) q1

--select * from D2_Daily;

SELECT top 5 * 
FROM D2_Daily
order by date desc;

SELECT *
	INTO D2_Info
	FROM (
		SELECT  I.fullTimeEmployees , I.logo_url , L.country , L.city , L."state" , S.sector , S.industry , F.* ,
		C.[currentPrice] , C.[priceToBook] , 
		round(((cast(marketCap as float)) /  sum(marketCap) over(order by marketCap rows between unbounded preceding and unbounded following))*100 ,4) as "weight"
		from company_info_dim I 
		left join company_Loc_dim L on I.Index_Loc = L."Index"
		left join company_sector_dim S on I.company_sector_dim_Index = S."Index"
		left join fact_stock_market F on F.Symbol = I.Symbol
		left join Price_Book C on F.Symbol = C.Ticker) q4;

select * from D2_Info;

SELECT top 5 *
FROM D2_Info;