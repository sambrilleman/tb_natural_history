setwd('C:/GitHub/tb_natural_history/')
source('load_data.R')

model          = 1
random_effects = FALSE
smear_status   = c('positive')

analysis$run_metropolis(model          = model, 
                        n_iterations   = 1000, 
                        n_burned       = 250,
                        smear_status   = smear_status, 
                        random_effects = random_effects)

# View(analysis$metropolis_records)
#analysis$produce_mcmc_outputs(model = 1,smear_status = c('positive'))

outputs = Outputs$new(analysis)
outputs$produce_mcmc_outputs(model          = model, 
                             smear_status   = smear_status, 
                             random_effects = random_effects)