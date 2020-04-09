SELECT [Address].[Country]
      ,COUNT(*) as [Number of Citizens per country] 
FROM [VSDB].[dbo].[Address]
GROUP BY [Address].[Country]
ORDER BY [Address].[Country] ASC