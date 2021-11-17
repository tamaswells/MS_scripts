#!perl

#**********************************************************
#*                                                        *
#*     XTD2XYZ - Convert XTD files into XYZ format        *
#*                                                        *
#**********************************************************
# Version: 0.1
# Author: Andrea Minoia
# Date: 08/09/2010
#
# Convert MS trajectory xtd file into xYZ trajectory file.
# Backup of files that are about to be overwritten is managed
# by MS. The most recent file is that with higher index number (N)
# The script has to be in the same directory of the
# structure to modify and the user has to update the
# variable $doc (line 31) according to the name of the
# file containing the trajectory.
# The xmol trajectory is stored in trj.txt file and it is not
# possible to rename the file within MS, nor it is possible to
# automatically export it as xyz or car file. You should manage
# the new trajectory manually for further use (e.g. VMD)
#
# Modificator: Sobereva (sobereva@sina.com)
# Date: 2012-May-23
# The range of the frames to be outputted can be altered by line 49 and 51

use strict;
use MaterialsScript qw(:all);

#open the multiframe trajectory structure file or die

my $doc = $Documents{"./PBS.xtd"};

if (!$doc) {die "no document";}

my $trajectory = $doc->Trajectory;

if ($trajectory->NumFrames>1) {

    print "Found ".$trajectory->NumFrames." frames in the trajectory\n";
    # Open new xmol trajectory file
    my $xmolFile=Documents->New("trj.txt");
   
    #get atoms in the structure
    my $lattice=$doc->SymmetryDefinition;
#    my $atoms = $doc->Atoms;
    my $atoms = $doc->DisplayRange->Atoms;
    my $Natoms=@$atoms;
    #print $lattice->vectorA->X;
    # loops over the frames
    my $framebegin=1;
    my $frameend=$trajectory->NumFrames;
#    my $frameend=10;
    for (my $frame=$framebegin; $frame<=$frameend; ++$frame){
        $trajectory->CurrentFrame = $frame;
        #write header xyz
        $xmolFile->Append(sprintf "%i \n", $Natoms);
        #$xmolFile->Append(sprintf "%s %i \n", "Frame",$frame);
        $xmolFile->Append(sprintf "Lattice=\"%f %f %f %f %f %f %f %f %f\" Properties=species:S:1:pos:R:3 pbc=\"T T T\" Time=\"%f\" Energy=\"%f\"\n",$lattice->vectorA->X,$lattice->vectorA->Y,$lattice->vectorA->Z,$lattice->vectorB->X,$lattice->vectorB->Y,$lattice->vectorB->Z,$lattice->vectorC->X,$lattice->vectorC->Y,$lattice->vectorC->Z,$trajectory->FrameTime, $trajectory->FrameEnergy);
        foreach my $atom (@$atoms) {
            # write atom symbol and x-y-z- coordinates
            $xmolFile->Append(sprintf "%s %f  %f  %f \n",$atom->ElementSymbol, $atom->X, $atom->Y,

$atom->Z);
        }   
    }
    #close trajectory file
    $xmolFile->Close;
}
else {
    print "The " . $doc->Name . " is not a multiframe trajectory file \n";
}

