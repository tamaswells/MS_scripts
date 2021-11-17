use strict;
use MaterialsScript qw(:all);

#open the multiframe trajectory structure file or die

my $doc = $Documents{"./reactant-483.xtd"};

if (!$doc) {die "no document";}

my $results = Modules->Forcite->Analysis->TotalKineticEnergy($doc, Settings(
	ComputeRunningAverages => "No"));
my $outTotalKineticChart = $results->TotalKineticChart;
my $outTotalKineticChartAsStudyTable = $results->TotalKineticChartAsStudyTable;

my $results = Modules->Forcite->Analysis->PotentialEnergyComponents($doc, Settings(
	ComputeRunningAverages => "No"));
my $outPotentialEnergyComponentsChart = $results->PotentialEnergyComponentsChart;
my $outPotentialEnergyComponentsChartAsStudyTable = $results->PotentialEnergyComponentsChartAsStudyTable;

my $results = Modules->Forcite->Analysis->Pressure($doc, Settings(
	ComputeRunningAverages => "No"));
my $outPressureChart = $results->PressureChart;
my $outPressureChartAsStudyTable = $results->PressureChartAsStudyTable;

my $results = Modules->Forcite->Analysis->CellParameters($doc, Settings(
	ComputeRunningAverages => "No"));
my $outCellParametersChart = $results->CellParametersChart;
my $outCellParametersChartAsStudyTable = $results->CellParametersChartAsStudyTable;

