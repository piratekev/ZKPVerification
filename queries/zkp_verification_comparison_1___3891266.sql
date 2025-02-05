-- part of a query repo
-- query name: ZKP verification comparison 1
-- query link: https://dune.com/queries/3891266


with base as (
    -- infra/rollup
    select 'infra' as type, 'Ethereum' as chain, 'zkSync Era' as protocol, * from dune.nebra.result_zksync_era_verification_base -- https://dune.com/queries/3890722
    UNION ALL
    select 'infra' as type, 'Ethereum' as chain, 'Scroll' as protocol, * from dune.nebra.result_scroll_verification_base -- https://dune.com/queries/3916549
    UNION ALL
    select 'infra' as type, 'Ethereum' as chain, 'Linea' as protocol, * from dune.nebra.result_linea_verification_base -- https://dune.com/queries/3916566
    UNION ALL
    select 'infra' as type, 'Ethereum' as chain, 'Loopring' as protocol, * from dune.nebra.result_loopring_verfication_base -- https://dune.com/queries/3902706
    UNION ALL
    select 'infra' as type, 'Ethereum' as chain, 'Aztec' as protocol, * from dune.nebra.result_aztec_verification_base -- https://dune.com/queries/3916310
    UNION ALL
    select 'infra' as type, 'Ethereum' as chain, 'Polygon zkEVM' as protocol, * from dune.nebra.result_polygon_zk_evm_verification_base -- https://dune.com/queries/3916389
    UNION ALL
    select 'infra' as type, 'Ethereum' as chain, 'Starknet' as protocol, * from dune.nebra.result_starknet_verification_base -- https://dune.com/queries/3948217
    
    -- app
    UNION ALL
    select 'app' as type, 'Ethereum' as chain, 'dYdX (StarkEx)' as protocol, * from dune.nebra.result_dydx_stark_ex_verification_base -- https://dune.com/queries/3902468
    UNION ALL
    select 'app' as type, 'Ethereum' as chain, 'Tornado Cash' as protocol, * from dune.nebra.result_tornado_cash_verification_base -- https://dune.com/queries/3902791
    UNION ALL
    select 'app' as type, 'Ethereum' as chain, 'Nocturne' as protocol, * from dune.nebra.result_nocturne_verification_base -- https://dune.com/queries/3916443
    UNION ALL
    select 'app' as type, 'Ethereum' as chain, 'Railgun' as protocol, * from dune.nebra.result_railgun_verification_base -- https://dune.com/queries/3902794
    UNION ALL
    select 'app' as type, 'Ethereum' as chain, 'StarEX projects (excl. Starknet L2)' as protocol, * from dune.nebra.result_stark_ex_projects_excl_starknet_l_2_verification_base -- https://dune.com/queries/3973955
    UNION ALL
    select 'app' as type, 'Ethereum' as chain, 'Worldcoin' as protocol, * from dune.nebra.result_worldcoin_verification_base -- https://dune.com/queries/4149850
    UNION ALL
    select 'app' as type, 'Ethereum' as chain, 'RISCZero' as protocol, * from dune.nebra.result_risc_zero_verification_base -- https://dune.com/queries/4149868
    UNION ALL
    select 'app' as type, 'Ethereum' as chain, 'Succinct' as protocol, * from dune.nebra.result_succinct_verification_base -- https://dune.com/queries/4149866
    
    -- exclude because it's on OP/L2
    -- select 'infra' as type, 'Ethereum' as chain, 'Worldcoin' as protocol, * from dune.nebra.result_worldcoin_op_verification_base -- https://dune.com/queries/3902422

)

select date_trunc('month', block_date) as time
    , protocol
    , sum(verifying_calls) as num_calls
    , sum(verifying_cost_eth) as cost_eth
    , sum(verifying_cost_usd) as cost_usd
from base
where block_date >= now() - interval '4' year
-- where block_date < date_trunc('week', NOW()) -- excluding current week 
group by 1,2