## Main script for running the model integration examples
library("treeSeedlingMetamodelData")
library(LaplacesDemon)
data(seedlings, envir = environment())


sp <- seedlings$species[1]


# looping over species starting here here
# for(sp in seedlings$species) {
	naiveDat <- naive_ld_dat(seedlings$sdm_adults[[sp]])

	# note that this is an EXAMPLE - it is impossible to do this automatically, because fitting LD models 
	# is done by trial and error
	naiveMod <- LaplacesDemon::LaplacesDemon(naive_lp, naiveDat, LaplacesDemon::GIV(naive_lp, naiveDat, PGF=TRUE), 
		Algorithm = "AM", specs=list(Adaptive = 50, Periodicity = 50), Iterations = 100)

	# for some guidance, use consort()
	Consort(naiveMod)


	## survival model
	survDat <- survival_ld_dat(seedlings$survival[[sp]])
	survMod <- LaplacesDemon::LaplacesDemon(survival_lp, survDat, LaplacesDemon::GIV(survival_lp, survDat, PGF=TRUE), 
		Algorithm = "AM", specs=list(Adaptive = 50, Periodicity = 50), Iterations = 100)


	# integrated model
	intDat <- integrated_ld_dat(seedlings$sdm_adults[[sp]], seedlings$survival[[sp]])
	intMod <- LaplacesDemon::LaplacesDemon(integrated_lp, intDat, LaplacesDemon::GIV(integrated_lp, intDat, PGF=TRUE), 
		Algorithm = "AM", specs=list(Adaptive = 50, Periodicity = 50), Iterations = 100)


# }