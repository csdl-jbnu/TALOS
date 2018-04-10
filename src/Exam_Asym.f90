!
! =============================================================================
!
! Module - Exam_Asym
! Last Updated : 04/10/2018, by Hyungmin Jun (hyungminjun@outlook.com)
!
! =============================================================================
!
! This is part of PERDIX-6P, which allows scientists to build and solve
! the sequence design of complex DNAnanostructures.
! Copyright 2018 Hyungmin Jun. All rights reserved.
!
! License - GPL version 3
! PERDIX-6P is free software: you can redistribute it and/or modify it under
! the terms of the GNU General Public License as published by the Free Software
! Foundation, either version 3 of the License, or any later version.
! PERDIX-6P is distributed in the hope that it will be useful, but WITHOUT
! ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS
! FOR A PARTICULAR PURPOSE. See the GNU General Public License
! for more details.
! You should have received a copy of the GNU General Public License along with
! this program. If not, see <http://www.gnu.org/licenses/>.
!
! -----------------------------------------------------------------------------
!
module Exam_Asym

    use Data_Prob
    use Data_Geom

    use Mani

    implicit none

    public Exam_Asym_Tetra_63_63_63_73_52_42
    public Exam_Asym_Tetra_105_63_84_84_63_42
    public Exam_Asym_Tri_Bipyramid_42_63_84_105

    public Exam_Asym_Triangle
    public Exam_Asym_Biscribed_Propello_Tetrahedron
    public Exam_Asym_Biscribed_Propello_Cube

    public Exam_Asym_Ball             ! V=42,  E=120, F=80
    public Exam_Asym_Nickedtorus      ! V=98,  E=288, F=192
    public Exam_Asym_Helix            ! V=105, E=309, F=206
    public Exam_Asym_Rod              ! V=105, E=309, F=206
    public Exam_Asym_Stickman         ! V=96,  E=282, F=188
    public Exam_Asym_Bottle           ! V=68,  E=198, F=132
    public Exam_Asym_Bunny            ! V=70,  E=204, F=136

contains

! -----------------------------------------------------------------------------

! Example of asymmetric tetrahedron 63-63-63-73-52-42bp
subroutine Exam_Asym_Tetra_63_63_63_73_52_42(prob, geom)
    type(ProbType), intent(inout) :: prob
    type(GeomType), intent(inout) :: geom

    character(10) :: char_sec, char_bp, char_start_bp

    write(unit=char_sec,      fmt = "(i10)"), prob.sel_sec
    write(unit=char_bp,       fmt = "(i10)"), prob.n_bp_edge
    write(unit=char_start_bp, fmt = "(i10)"), para_start_bp_ID

    prob.name_prob = "Asym Tetra 63-63-63-73-52-42"
    prob.name_file = "Asym_Tetra_63_63_63_73_52_42"//&
        "_"//trim(adjustl(trim(char_sec)))//"cs"//&
        "_"//trim(adjustl(trim(char_bp)))//"bp"//&
        "_"//trim(para_vertex_design)

    ! Preset parameters
    if(para_preset == "on") then
        if(para_vertex_design == "flat") then
            para_junc_ang        = "min"    ! Junctional gap
            para_unpaired_scaf   = "off"    ! Unpaired scaffold nucleotides
            para_n_base_tn       = 7        ! The number of nucleotides

            ! Folding conditions
            para_const_edge_mesh = "on"     ! Constant edge length
        else if(para_vertex_design == "mitered") then
            para_junc_ang        = "opt"    ! Junctional gap
            para_unpaired_scaf   = "on"     ! Unpaired scaffold nucleotides
            para_n_base_tn       = -1       ! The number of nucleotides
        end if
    end if

    ! Set geometric type and view (atom, cylinder size, move_x, move_y)
    call Mani_Set_View_Color(prob, [195, 153, 107], "xy")

    ! Allocate point and face structure
    geom.n_iniP = 4
    geom.n_face = 4

    allocate(geom.iniP(geom.n_iniP))
    allocate(geom.face(geom.n_face))

    ! Set point position vectors
    geom.iniP(1).pos(1:3) = [  0.000000d0,  0.000000d0,  0.000000d0 ]
    geom.iniP(2).pos(1:3) = [  0.000000d0, 63.000000d0,  0.000000d0 ]
    geom.iniP(3).pos(1:3) = [ 59.499976d0, 20.706349d0,  0.000000d0 ]
    geom.iniP(4).pos(1:3) = [ 37.426315d0, 41.539683d0, 29.029739d0 ]

    ! Set face connnectivity
    geom.face(1).n_poi = 3; allocate(geom.face(1).poi(3)); geom.face(1).poi(1:3) = [ 1, 4, 2 ]
    geom.face(2).n_poi = 3; allocate(geom.face(2).poi(3)); geom.face(2).poi(1:3) = [ 1, 3, 4 ]
    geom.face(3).n_poi = 3; allocate(geom.face(3).poi(3)); geom.face(3).poi(1:3) = [ 1, 2, 3 ]
    geom.face(4).n_poi = 3; allocate(geom.face(4).poi(3)); geom.face(4).poi(1:3) = [ 2, 4, 3 ]
end subroutine Exam_Asym_Tetra_63_63_63_73_52_42

! -----------------------------------------------------------------------------

! Example of asymmetric tetrahedron 105-63-84-84-63-42bp
subroutine Exam_Asym_Tetra_105_63_84_84_63_42(prob, geom)
    type(ProbType), intent(inout) :: prob
    type(GeomType), intent(inout) :: geom

    character(10) :: char_sec, char_bp, char_start_bp

    write(unit=char_sec,      fmt = "(i10)"), prob.sel_sec
    write(unit=char_bp,       fmt = "(i10)"), prob.n_bp_edge
    write(unit=char_start_bp, fmt = "(i10)"), para_start_bp_ID

    prob.name_prob = "Asym Tetra 105_63_84_84_63_42"
    prob.name_file = "46_Asym_Tetra_105_63_84_84_63_42"//&
        "_"//trim(adjustl(trim(char_sec)))//"cs"//&
        "_"//trim(adjustl(trim(char_bp)))//"bp"//&
        "_"//trim(para_vertex_design)

    ! Preset parameters
    if(para_preset == "on") then
        if(para_vertex_design == "flat") then
            para_junc_ang        = "min"    ! Junctional gap
            para_unpaired_scaf   = "off"    ! Unpaired scaffold nucleotides
            para_n_base_tn       = 7        ! The number of nucleotides

            ! Folding conditions
            para_const_edge_mesh = "on"     ! Constant edge length
        else if(para_vertex_design == "mitered") then
            para_junc_ang        = "opt"    ! Junctional gap
            para_unpaired_scaf   = "on"     ! Unpaired scaffold nucleotides
            para_n_base_tn       = -1       ! The number of nucleotides

            para_un_depend_angle = "on"
        end if
    end if

    ! Set geometric type and view (atom, cylinder size, move_x, move_y)
    call Mani_Set_View_Color(prob, [150, 58, 228], "xy")

    ! Allocate point and face structure
    geom.n_iniP = 4
    geom.n_face = 4

    allocate(geom.iniP(geom.n_iniP))
    allocate(geom.face(geom.n_face))

    ! 105-63-84-84-63-42
    geom.iniP(1).pos(1:3) = [  0.000000d0,   0.000000d0,  0.000000d0 ]
    geom.iniP(2).pos(1:3) = [  0.000000d0, 105.000000d0,  0.000000d0 ]
    geom.iniP(3).pos(1:3) = [ 50.400000d0,  37.800000d0,  0.000000d0 ]
    geom.iniP(4).pos(1:3) = [ 41.475000d0,  67.200000d0, 28.635369d0 ]

    ! Set face connnectivity
    geom.face(1).n_poi = 3; allocate(geom.face(1).poi(3)); geom.face(1).poi(1:3) = [ 1, 4, 2 ]
    geom.face(2).n_poi = 3; allocate(geom.face(2).poi(3)); geom.face(2).poi(1:3) = [ 1, 3, 4 ]
    geom.face(3).n_poi = 3; allocate(geom.face(3).poi(3)); geom.face(3).poi(1:3) = [ 1, 2, 3 ]
    geom.face(4).n_poi = 3; allocate(geom.face(4).poi(3)); geom.face(4).poi(1:3) = [ 2, 4, 3 ]
end subroutine Exam_Asym_Tetra_105_63_84_84_63_42

! -----------------------------------------------------------------------------

! Example of asymetric triangular bipyramid 42-63-84-105
subroutine Exam_Asym_Tri_Bipyramid_42_63_84_105(prob, geom)
    type(ProbType), intent(inout) :: prob
    type(GeomType), intent(inout) :: geom

    character(10) :: char_sec, char_bp, char_start_bp

    write(unit=char_sec,      fmt = "(i10)"), prob.sel_sec
    write(unit=char_bp,       fmt = "(i10)"), prob.n_bp_edge
    write(unit=char_start_bp, fmt = "(i10)"), para_start_bp_ID

    prob.name_prob = "Asym Tri Bipyramid 42-63-84-105"
    prob.name_file = "Asym_Tri_Bipyramid_42_63_84_105"//&
        "_"//trim(adjustl(trim(char_sec)))//"cs"//&
        "_"//trim(adjustl(trim(char_bp)))//"bp"//&
        "_"//trim(para_vertex_design)

    ! Preset parameters
    if(para_preset == "on") then
        if(para_vertex_design == "flat") then
            para_junc_ang        = "min"    ! Junctional gap
            para_unpaired_scaf   = "off"    ! Unpaired scaffold nucleotides
            para_n_base_tn       = 7        ! The number of nucleotides

            ! Folding conditions
            para_const_edge_mesh = "on"     ! Constant edge length
        else if(para_vertex_design == "mitered") then
            para_junc_ang        = "opt"    ! Junctional gap
            para_unpaired_scaf   = "on"     ! Unpaired scaffold nucleotides
            para_n_base_tn       = -1       ! The number of nucleotides
        end if
    end if

    ! Set geometric type and view (atom, cylinder size, move_x, move_y)
    call Mani_Set_View_Color(prob, [195, 153, 107], "xy")

    ! Allocate point and face structure
    geom.n_iniP = 5
    geom.n_face = 6

    allocate(geom.iniP(geom.n_iniP))
    allocate(geom.face(geom.n_face))

    ! 105-63-84-84-63-42
    geom.iniP(1).pos(1:3) = [  0.000000d0,   0.000000d0,  0.000000d0 ]
    geom.iniP(2).pos(1:3) = [  0.000000d0, 105.000000d0,  0.000000d0 ]
    geom.iniP(3).pos(1:3) = [ 50.400000d0,  37.800000d0,  0.000000d0 ]
    geom.iniP(4).pos(1:3) = [ 41.475000d0,  67.200000d0, 28.635369d0 ]
    !geom.iniP(5).pos(1:3) = [ -119.0d0/40.0d0, 273.0d0/10.0d0, -( 7.0d0*1319.0d0**0.5d0)/8.0d0 ]    ! 84-63-42
    geom.iniP(5).pos(1:3) = [  189.0d0/10.0d0, 273.0d0/10.0d0, -(21.0d0*   6.0d0**0.5d0)/2.0d0 ]   ! 84-42-42
    !geom.iniP(5).pos(1:3) = [  329.0d0/10.0d0, 189.0d0/ 5.0d0, -( 7.0d0* 119.0d0**0.5d0)/2.0d0 ]    ! 84-42-63

    ! Set face connnectivity
    geom.face(1).n_poi = 3; allocate(geom.face(1).poi(3)); geom.face(1).poi(1:3) = [ 1, 4, 2 ]
    geom.face(2).n_poi = 3; allocate(geom.face(2).poi(3)); geom.face(2).poi(1:3) = [ 1, 3, 4 ]
    geom.face(3).n_poi = 3; allocate(geom.face(3).poi(3)); geom.face(3).poi(1:3) = [ 2, 4, 3 ]
    geom.face(4).n_poi = 3; allocate(geom.face(4).poi(3)); geom.face(4).poi(1:3) = [ 2, 5, 1 ]
    geom.face(5).n_poi = 3; allocate(geom.face(5).poi(3)); geom.face(5).poi(1:3) = [ 5, 3, 1 ]
    geom.face(6).n_poi = 3; allocate(geom.face(6).poi(3)); geom.face(6).poi(1:3) = [ 3, 5, 2 ]
end subroutine Exam_Asym_Tri_Bipyramid_42_63_84_105

! -----------------------------------------------------------------------------

! Example of asymmetric triangles
subroutine Exam_Asym_Triangle(prob, geom)
    type(ProbType), intent(inout) :: prob
    type(GeomType), intent(inout) :: geom

    character(10) :: char_sec, char_bp, char_start_bp

    write(unit=char_sec,      fmt = "(i10)"), prob.sel_sec
    write(unit=char_bp,       fmt = "(i10)"), prob.n_bp_edge
    write(unit=char_start_bp, fmt = "(i10)"), para_start_bp_ID

    prob.name_prob = "Asym Triangle"
    prob.name_file = "Asym_Triangle"//&
        "_"//trim(adjustl(trim(char_sec)))//"cs"//&
        "_"//trim(adjustl(trim(char_bp)))//"bp"//&
        "_"//trim(para_vertex_design)

    ! Problem specified preset parameters
    para_set_seq_scaf   = 1     ! Scaffold sequence, 0 - M13mp18(7249nt), 1 - import sequence from seq.txt, 2 - random
    para_set_start_scaf = 1     ! Starting nucleotide position of scaffold strand

    if(para_vertex_design == "flat" .and. para_preset == "on") then
        para_junc_ang        = "min"    ! Junction gap modification for different arm angle
        para_const_edge_mesh = "on"     ! Constant edge length from polyhedra mesh
        para_unpaired_scaf   = "off"    ! Unpaired scaffold nucleotides
        para_n_base_tn       = 7
    end if

    ! Set geometric type and view (atom, cylinder size, move_x, move_y)
    call Mani_Set_View_Color(prob, [195, 153, 107], "xy")

    ! Allocate point and face structure
    geom.n_iniP = 9
    geom.n_face = 14

    allocate(geom.iniP(geom.n_iniP))
    allocate(geom.face(geom.n_face))

    ! Set point position vectors
    geom.iniP(1).pos(1:3) = [  0.000000d0,  0.000000d0,  1.000000d0 ]
    geom.iniP(2).pos(1:3) = [  0.000000d0,  0.000000d0, -1.000000d0 ]
    geom.iniP(3).pos(1:3) = [  0.000000d0,  1.000000d0,  0.000000d0 ]
    geom.iniP(4).pos(1:3) = [  0.000000d0, -1.000000d0,  0.000000d0 ]
    geom.iniP(5).pos(1:3) = [  1.000000d0,  0.000000d0,  0.000000d0 ]
    geom.iniP(6).pos(1:3) = [ -1.000000d0,  0.000000d0,  0.000000d0 ]
    geom.iniP(7).pos(1:3) = [ -1.000000d0,  1.000000d0, -1.000000d0 ]
    geom.iniP(8).pos(1:3) = [  0.333333d0,  1.333333d0, -1.333333d0 ]
    geom.iniP(9).pos(1:3) = [  1.000000d0,  1.000000d0,  1.000000d0 ]

    ! Set face connnectivity
    geom.face( 1).n_poi = 3; allocate(geom.face( 1).poi(3)); geom.face( 1).poi(1:3) = [ 1, 5, 9 ]
    geom.face( 2).n_poi = 3; allocate(geom.face( 2).poi(3)); geom.face( 2).poi(1:3) = [ 1, 9, 3 ]
    geom.face( 3).n_poi = 3; allocate(geom.face( 3).poi(3)); geom.face( 3).poi(1:3) = [ 9, 5, 3 ]
    geom.face( 4).n_poi = 3; allocate(geom.face( 4).poi(3)); geom.face( 4).poi(1:3) = [ 1, 4, 5 ]
    geom.face( 5).n_poi = 3; allocate(geom.face( 5).poi(3)); geom.face( 5).poi(1:3) = [ 1, 6, 4 ]
    geom.face( 6).n_poi = 3; allocate(geom.face( 6).poi(3)); geom.face( 6).poi(1:3) = [ 1, 3, 6 ]
    geom.face( 7).n_poi = 3; allocate(geom.face( 7).poi(3)); geom.face( 7).poi(1:3) = [ 2, 3, 5 ]
    geom.face( 8).n_poi = 3; allocate(geom.face( 8).poi(3)); geom.face( 8).poi(1:3) = [ 2, 5, 4 ]
    geom.face( 9).n_poi = 3; allocate(geom.face( 9).poi(3)); geom.face( 9).poi(1:3) = [ 2, 4, 6 ]
    geom.face(10).n_poi = 3; allocate(geom.face(10).poi(3)); geom.face(10).poi(1:3) = [ 2, 6, 7 ]
    geom.face(11).n_poi = 3; allocate(geom.face(11).poi(3)); geom.face(11).poi(1:3) = [ 3, 7, 6 ]
    geom.face(12).n_poi = 3; allocate(geom.face(12).poi(3)); geom.face(12).poi(1:3) = [ 3, 8, 7 ]
    geom.face(13).n_poi = 3; allocate(geom.face(13).poi(3)); geom.face(13).poi(1:3) = [ 3, 2, 8 ]
    geom.face(14).n_poi = 3; allocate(geom.face(14).poi(3)); geom.face(14).poi(1:3) = [ 2, 7, 8 ]
end subroutine Exam_Asym_Triangle

! -----------------------------------------------------------------------------

! Example of Biscribed propello tetrahedron
subroutine Exam_Asym_Biscribed_Propello_Tetrahedron(prob, geom)
    type(ProbType), intent(inout) :: prob
    type(GeomType), intent(inout) :: geom

    double precision :: c0, c1, c2, c3
    character(10) :: char_sec, char_bp, char_start_bp

    write(unit=char_sec,      fmt = "(i10)"), prob.sel_sec
    write(unit=char_bp,       fmt = "(i10)"), prob.n_bp_edge
    write(unit=char_start_bp, fmt = "(i10)"), para_start_bp_ID

    prob.name_prob = "Asym Biscribed Propello Tetrahedron"
    prob.name_file = "Asym_Biscribed_Propello_Tetrahedron"//&
        "_"//trim(adjustl(trim(char_sec)))//"cs"//&
        "_"//trim(adjustl(trim(char_bp)))//"bp"//&
        "_"//trim(para_vertex_design)

    ! Problem specified preset parameters
    if(para_vertex_design == "flat" .and. para_preset == "on") then
        para_junc_ang        = "max"    ! Junction gap modification for different arm angle
        para_const_edge_mesh = "off"    ! Constant edge length from polyhedra mesh
        para_unpaired_scaf   = "off"    ! Unpaired scaffold nucleotides
        para_n_base_tn       = 7
    end if

    ! Set geometric type and view (atom, cylinder size, move_x, move_y)
    call Mani_Set_View_Color(prob, [195, 153, 107], "xy")

    ! Allocate point and face structure
    geom.n_iniP = 16
    geom.n_face = 16

    allocate(geom.iniP(geom.n_iniP))
    allocate(geom.face(geom.n_face))

    ! Set point position vectors
    c0 = 0.041226573367477290238151003637d0
    c1 = 0.447594291856692697052238850001d0
    c2 = 0.577350269189625764509148780502d0
    c3 = 0.893285911422363030309232997113d0

    geom.iniP( 1).pos(1:3) = [  c1,  c0,  c3 ]
    geom.iniP( 2).pos(1:3) = [  c1, -c0, -c3 ]
    geom.iniP( 3).pos(1:3) = [ -c1, -c0,  c3 ]
    geom.iniP( 4).pos(1:3) = [ -c1,  c0, -c3 ]
    geom.iniP( 5).pos(1:3) = [  c3,  c1,  c0 ]
    geom.iniP( 6).pos(1:3) = [  c3, -c1, -c0 ]
    geom.iniP( 7).pos(1:3) = [ -c3, -c1,  c0 ]
    geom.iniP( 8).pos(1:3) = [ -c3,  c1, -c0 ]
    geom.iniP( 9).pos(1:3) = [  c0,  c3,  c1 ]
    geom.iniP(10).pos(1:3) = [  c0, -c3, -c1 ]
    geom.iniP(11).pos(1:3) = [ -c0, -c3,  c1 ]
    geom.iniP(12).pos(1:3) = [ -c0,  c3, -c1 ]
    geom.iniP(13).pos(1:3) = [  c2, -c2,  c2 ]
    geom.iniP(14).pos(1:3) = [  c2,  c2, -c2 ]
    geom.iniP(15).pos(1:3) = [ -c2,  c2,  c2 ]
    geom.iniP(16).pos(1:3) = [ -c2, -c2, -c2 ]

    ! Set face connnectivity
    geom.face( 1).n_poi = 4; allocate(geom.face( 1).poi(4)); geom.face( 1).poi(1:4) = [  13,  1,  3, 11 ]
    geom.face( 2).n_poi = 4; allocate(geom.face( 2).poi(4)); geom.face( 2).poi(1:4) = [  13, 11, 10,  6 ]
    geom.face( 3).n_poi = 4; allocate(geom.face( 3).poi(4)); geom.face( 3).poi(1:4) = [  13,  6,  5,  1 ]
    geom.face( 4).n_poi = 4; allocate(geom.face( 4).poi(4)); geom.face( 4).poi(1:4) = [  14,  2,  4, 12 ]
    geom.face( 5).n_poi = 4; allocate(geom.face( 5).poi(4)); geom.face( 5).poi(1:4) = [  14, 12,  9,  5 ]
    geom.face( 6).n_poi = 4; allocate(geom.face( 6).poi(4)); geom.face( 6).poi(1:4) = [  14,  5,  6,  2 ]
    geom.face( 7).n_poi = 4; allocate(geom.face( 7).poi(4)); geom.face( 7).poi(1:4) = [  15,  3,  1,  9 ]
    geom.face( 8).n_poi = 4; allocate(geom.face( 8).poi(4)); geom.face( 8).poi(1:4) = [  15,  9, 12,  8 ]
    geom.face( 9).n_poi = 4; allocate(geom.face( 9).poi(4)); geom.face( 9).poi(1:4) = [  15,  8,  7,  3 ]
    geom.face(10).n_poi = 4; allocate(geom.face(10).poi(4)); geom.face(10).poi(1:4) = [  16,  4,  2, 10 ]
    geom.face(11).n_poi = 4; allocate(geom.face(11).poi(4)); geom.face(11).poi(1:4) = [  16, 10, 11,  7 ]
    geom.face(12).n_poi = 4; allocate(geom.face(12).poi(4)); geom.face(12).poi(1:4) = [  16,  7,  8,  4 ]
    geom.face(13).n_poi = 3; allocate(geom.face(13).poi(3)); geom.face(13).poi(1:3) = [   1,  5,  9 ]
    geom.face(14).n_poi = 3; allocate(geom.face(14).poi(3)); geom.face(14).poi(1:3) = [   2,  6, 10 ]
    geom.face(15).n_poi = 3; allocate(geom.face(15).poi(3)); geom.face(15).poi(1:3) = [   3,  7, 11 ]
    geom.face(16).n_poi = 3; allocate(geom.face(16).poi(3)); geom.face(16).poi(1:3) = [   4,  8, 12 ]
end subroutine Exam_Asym_Biscribed_Propello_Tetrahedron

! -----------------------------------------------------------------------------

! Example of Biscribed propello cube
subroutine Exam_Asym_Biscribed_Propello_Cube(prob, geom)
    type(ProbType), intent(inout) :: prob
    type(GeomType), intent(inout) :: geom

    double precision :: c0, c1, c2
    character(10) :: char_sec, char_bp, char_start_bp

    write(unit=char_sec,      fmt = "(i10)"), prob.sel_sec
    write(unit=char_bp,       fmt = "(i10)"), prob.n_bp_edge
    write(unit=char_start_bp, fmt = "(i10)"), para_start_bp_ID

    prob.name_prob = "Asym Biscribed Propello Cube"
    prob.name_file = "Asym_Biscribed_Propello_Cube"//&
        "_"//trim(adjustl(trim(char_sec)))//"cs"//&
        "_"//trim(adjustl(trim(char_bp)))//"bp"//&
        "_"//trim(para_vertex_design)

    ! Problem specified preset parameters
    if(para_vertex_design == "flat" .and. para_preset == "on") then
        para_junc_ang        = "max"    ! Junction gap modification for different arm angle
        para_const_edge_mesh = "off"    ! Constant edge length from polyhedra mesh
        para_unpaired_scaf   = "off"    ! Unpaired scaffold nucleotides
        para_n_base_tn       = 7
    end if

    ! Set geometric type and view (atom, cylinder size, move_x, move_y)
    call Mani_Set_View_Color(prob, [195, 153, 107], "xy")

    ! Allocate point and face structure
    geom.n_iniP = 32
    geom.n_face = 30

    allocate(geom.iniP(geom.n_iniP))
    allocate(geom.face(geom.n_face))

    ! Set point position vectors
    c0 = 0.268318503889892044924746743411d0
    c1 = 0.437902382065032587008255021493d0
    c2 = 0.649038600739057169667625426214d0

    geom.iniP( 1).pos(1:3) = [     c1,     c0,  1.0d0 ]
    geom.iniP( 2).pos(1:3) = [     c1,    -c0, -1.0d0 ]
    geom.iniP( 3).pos(1:3) = [    -c1,    -c0,  1.0d0 ]
    geom.iniP( 4).pos(1:3) = [    -c1,     c0, -1.0d0 ]
    geom.iniP( 5).pos(1:3) = [  1.0d0,     c1,     c0 ]
    geom.iniP( 6).pos(1:3) = [  1.0d0,    -c1,    -c0 ]
    geom.iniP( 7).pos(1:3) = [ -1.0d0,    -c1,     c0 ]
    geom.iniP( 8).pos(1:3) = [ -1.0d0,     c1,    -c0 ]
    geom.iniP( 9).pos(1:3) = [     c0,  1.0d0,     c1 ]
    geom.iniP(10).pos(1:3) = [     c0, -1.0d0,    -c1 ]
    geom.iniP(11).pos(1:3) = [    -c0, -1.0d0,     c1 ]
    geom.iniP(12).pos(1:3) = [    -c0,  1.0d0,    -c1 ]
    geom.iniP(13).pos(1:3) = [     c0,    -c1,  1.0d0 ]
    geom.iniP(14).pos(1:3) = [     c0,     c1, -1.0d0 ]
    geom.iniP(15).pos(1:3) = [    -c0,     c1,  1.0d0 ]
    geom.iniP(16).pos(1:3) = [    -c0,    -c1, -1.0d0 ]
    geom.iniP(17).pos(1:3) = [  1.0d0,    -c0,     c1 ]
    geom.iniP(18).pos(1:3) = [  1.0d0,     c0,    -c1 ]
    geom.iniP(19).pos(1:3) = [ -1.0d0,     c0,     c1 ]
    geom.iniP(20).pos(1:3) = [ -1.0d0,    -c0,    -c1 ]
    geom.iniP(21).pos(1:3) = [     c1, -1.0d0,     c0 ]
    geom.iniP(22).pos(1:3) = [     c1,  1.0d0,    -c0 ]
    geom.iniP(23).pos(1:3) = [    -c1,  1.0d0,     c0 ]
    geom.iniP(24).pos(1:3) = [    -c1, -1.0d0,    -c0 ]
    geom.iniP(25).pos(1:3) = [     c2,     c2,     c2 ]
    geom.iniP(26).pos(1:3) = [     c2,     c2,    -c2 ]
    geom.iniP(27).pos(1:3) = [     c2,    -c2,     c2 ]
    geom.iniP(28).pos(1:3) = [     c2,    -c2,    -c2 ]
    geom.iniP(29).pos(1:3) = [    -c2,     c2,     c2 ]
    geom.iniP(30).pos(1:3) = [    -c2,     c2,    -c2 ]
    geom.iniP(31).pos(1:3) = [    -c2,    -c2,     c2 ]
    geom.iniP(32).pos(1:3) = [    -c2,    -c2,    -c2 ]

    ! Set face connnectivity
    geom.face( 1).n_poi = 4; allocate(geom.face( 1).poi(4)); geom.face( 1).poi(1:4) = [  2, 12,  0, 14 ]
    geom.face( 2).n_poi = 4; allocate(geom.face( 2).poi(4)); geom.face( 2).poi(1:4) = [  3, 13,  1, 15 ]
    geom.face( 3).n_poi = 4; allocate(geom.face( 3).poi(4)); geom.face( 3).poi(1:4) = [  4, 16,  5, 17 ]
    geom.face( 4).n_poi = 4; allocate(geom.face( 4).poi(4)); geom.face( 4).poi(1:4) = [  7, 19,  6, 18 ]
    geom.face( 5).n_poi = 4; allocate(geom.face( 5).poi(4)); geom.face( 5).poi(1:4) = [  8, 21, 11, 22 ]
    geom.face( 6).n_poi = 4; allocate(geom.face( 6).poi(4)); geom.face( 6).poi(1:4) = [  9, 20, 10, 23 ]
    geom.face( 7).n_poi = 4; allocate(geom.face( 7).poi(4)); geom.face( 7).poi(1:4) = [ 24,  0, 16,  4 ]
    geom.face( 8).n_poi = 4; allocate(geom.face( 8).poi(4)); geom.face( 8).poi(1:4) = [ 24,  4, 21,  8 ]
    geom.face( 9).n_poi = 4; allocate(geom.face( 9).poi(4)); geom.face( 9).poi(1:4) = [ 24,  8, 14,  0 ]
    geom.face(10).n_poi = 4; allocate(geom.face(10).poi(4)); geom.face(10).poi(1:4) = [ 25, 13, 11, 21 ]
    geom.face(11).n_poi = 4; allocate(geom.face(11).poi(4)); geom.face(11).poi(1:4) = [ 25, 21,  4, 17 ]
    geom.face(12).n_poi = 4; allocate(geom.face(12).poi(4)); geom.face(12).poi(1:4) = [ 25, 17,  1, 13 ]
    geom.face(13).n_poi = 4; allocate(geom.face(13).poi(4)); geom.face(13).poi(1:4) = [ 26, 12, 10, 20 ]
    geom.face(14).n_poi = 4; allocate(geom.face(14).poi(4)); geom.face(14).poi(1:4) = [ 26, 20,  5, 16 ]
    geom.face(15).n_poi = 4; allocate(geom.face(15).poi(4)); geom.face(15).poi(1:4) = [ 26, 16,  0, 12 ]
    geom.face(16).n_poi = 4; allocate(geom.face(16).poi(4)); geom.face(16).poi(1:4) = [ 27,  1, 17,  5 ]
    geom.face(17).n_poi = 4; allocate(geom.face(17).poi(4)); geom.face(17).poi(1:4) = [ 27,  5, 20,  9 ]
    geom.face(18).n_poi = 4; allocate(geom.face(18).poi(4)); geom.face(18).poi(1:4) = [ 27,  9, 15,  1 ]
    geom.face(19).n_poi = 4; allocate(geom.face(19).poi(4)); geom.face(19).poi(1:4) = [ 28, 14,  8, 22 ]
    geom.face(20).n_poi = 4; allocate(geom.face(20).poi(4)); geom.face(20).poi(1:4) = [ 28, 22,  7, 18 ]
    geom.face(21).n_poi = 4; allocate(geom.face(21).poi(4)); geom.face(21).poi(1:4) = [ 28, 18,  2, 14 ]
    geom.face(22).n_poi = 4; allocate(geom.face(22).poi(4)); geom.face(22).poi(1:4) = [ 29,  3, 19,  7 ]
    geom.face(23).n_poi = 4; allocate(geom.face(23).poi(4)); geom.face(23).poi(1:4) = [ 29,  7, 22, 11 ]
    geom.face(24).n_poi = 4; allocate(geom.face(24).poi(4)); geom.face(24).poi(1:4) = [ 29, 11, 13,  3 ]
    geom.face(25).n_poi = 4; allocate(geom.face(25).poi(4)); geom.face(25).poi(1:4) = [ 30,  2, 18,  6 ]
    geom.face(26).n_poi = 4; allocate(geom.face(26).poi(4)); geom.face(26).poi(1:4) = [ 30,  6, 23, 10 ]
    geom.face(27).n_poi = 4; allocate(geom.face(27).poi(4)); geom.face(27).poi(1:4) = [ 30, 10, 12,  2 ]
    geom.face(28).n_poi = 4; allocate(geom.face(28).poi(4)); geom.face(28).poi(1:4) = [ 31, 15,  9, 23 ]
    geom.face(29).n_poi = 4; allocate(geom.face(29).poi(4)); geom.face(29).poi(1:4) = [ 31, 23,  6, 19 ]
    geom.face(30).n_poi = 4; allocate(geom.face(30).poi(4)); geom.face(30).poi(1:4) = [ 31, 19,  3, 15 ]
end subroutine Exam_Asym_Biscribed_Propello_Cube

! -----------------------------------------------------------------------------

! Example of Ball
subroutine Exam_Asym_Ball(prob, geom)
    type(ProbType), intent(inout) :: prob
    type(GeomType), intent(inout) :: geom

    character(10) :: char_sec, char_bp, char_start_bp

    write(unit=char_sec,      fmt = "(i10)"), prob.sel_sec
    write(unit=char_bp,       fmt = "(i10)"), prob.n_bp_edge
    write(unit=char_start_bp, fmt = "(i10)"), para_start_bp_ID

    prob.name_prob = "Ball"
    prob.name_file = "Ball"//&
        "_"//trim(adjustl(trim(char_sec)))//"cs"//&
        "_"//trim(adjustl(trim(char_bp)))//"bp"//&
        "_"//trim(para_vertex_design)

    ! Problem specified preset parameters
    if(para_vertex_design == "flat" .and. para_preset == "on") then
        para_junc_ang        = "max"    ! Junction gap modification for different arm angle
        para_const_edge_mesh = "off"    ! Constant edge length from polyhedra mesh
        para_unpaired_scaf   = "off"    ! Unpaired scaffold nucleotides
        para_n_base_tn       = 7
    end if

    ! Set geometric type and view (atom, cylinder size, move_x, move_y)
    call Mani_Set_View_Color(prob, [195, 153, 107], "xy")

    ! Allocate point and face structure
    geom.n_iniP = 42
    geom.n_face = 80

    allocate(geom.iniP(geom.n_iniP))
    allocate(geom.face(geom.n_face))

    ! Set point position vectors
    geom.iniP( 1).pos(1:3) = [   0.00000d0,   0.00000d0,  17.65689d0 ]; geom.iniP( 2).pos(1:3) = [  15.94015d0,   0.00000d0,   9.85156d0 ]
    geom.iniP( 3).pos(1:3) = [ -14.28471d0,  -8.82845d0,  -5.45626d0 ]; geom.iniP( 4).pos(1:3) = [ -17.65689d0,   0.00000d0,   0.00000d0 ]
    geom.iniP( 5).pos(1:3) = [   0.00000d0,  -9.85156d0,  15.94015d0 ]; geom.iniP( 6).pos(1:3) = [  -8.82845d0,  -5.45626d0,  14.28471d0 ]
    geom.iniP( 7).pos(1:3) = [  -8.82845d0,   5.45626d0,  14.28471d0 ]; geom.iniP( 8).pos(1:3) = [   0.00000d0,   9.85156d0, -15.94015d0 ]
    geom.iniP( 9).pos(1:3) = [ -15.94015d0,   0.00000d0,  -9.85156d0 ]; geom.iniP(10).pos(1:3) = [  -5.45626d0, -14.28471d0,   8.82845d0 ]
    geom.iniP(11).pos(1:3) = [  -9.85156d0, -15.94015d0,   0.00000d0 ]; geom.iniP(12).pos(1:3) = [   5.45626d0, -14.28471d0,  -8.82845d0 ]
    geom.iniP(13).pos(1:3) = [  -9.85156d0,  15.94015d0,   0.00000d0 ]; geom.iniP(14).pos(1:3) = [   5.45626d0,  14.28471d0,  -8.82845d0 ]
    geom.iniP(15).pos(1:3) = [   0.00000d0,  17.65689d0,   0.00000d0 ]; geom.iniP(16).pos(1:3) = [   9.85156d0, -15.94015d0,   0.00000d0 ]
    geom.iniP(17).pos(1:3) = [   0.00000d0, -17.65689d0,   0.00000d0 ]; geom.iniP(18).pos(1:3) = [   0.00000d0,  -9.85156d0, -15.94015d0 ]
    geom.iniP(19).pos(1:3) = [  -5.45626d0, -14.28471d0,  -8.82845d0 ]; geom.iniP(20).pos(1:3) = [  -5.45626d0,  14.28471d0,  -8.82845d0 ]
    geom.iniP(21).pos(1:3) = [  -8.82845d0,   5.45626d0, -14.28471d0 ]; geom.iniP(22).pos(1:3) = [  -8.82845d0,  -5.45626d0, -14.28471d0 ]
    geom.iniP(23).pos(1:3) = [ -14.28471d0,   8.82845d0,   5.45626d0 ]; geom.iniP(24).pos(1:3) = [  -5.45626d0,  14.28471d0,   8.82845d0 ]
    geom.iniP(25).pos(1:3) = [ -14.28471d0,  -8.82845d0,   5.45626d0 ]; geom.iniP(26).pos(1:3) = [ -15.94015d0,   0.00000d0,   9.85156d0 ]
    geom.iniP(27).pos(1:3) = [ -14.28471d0,   8.82845d0,  -5.45626d0 ]; geom.iniP(28).pos(1:3) = [   5.45626d0,  14.28471d0,   8.82845d0 ]
    geom.iniP(29).pos(1:3) = [  14.28471d0,   8.82845d0,   5.45626d0 ]; geom.iniP(30).pos(1:3) = [   9.85156d0,  15.94015d0,   0.00000d0 ]
    geom.iniP(31).pos(1:3) = [   5.45626d0, -14.28471d0,   8.82845d0 ]; geom.iniP(32).pos(1:3) = [   8.82845d0,  -5.45626d0,  14.28471d0 ]
    geom.iniP(33).pos(1:3) = [  14.28471d0,  -8.82845d0,   5.45626d0 ]; geom.iniP(34).pos(1:3) = [   0.00000d0,   9.85156d0,  15.94015d0 ]
    geom.iniP(35).pos(1:3) = [   8.82845d0,   5.45626d0,  14.28471d0 ]; geom.iniP(36).pos(1:3) = [   8.82845d0,  -5.45626d0, -14.28471d0 ]
    geom.iniP(37).pos(1:3) = [   8.82845d0,   5.45626d0, -14.28471d0 ]; geom.iniP(38).pos(1:3) = [   0.00000d0,   0.00000d0, -17.65689d0 ]
    geom.iniP(39).pos(1:3) = [  17.65689d0,   0.00000d0,   0.00000d0 ]; geom.iniP(40).pos(1:3) = [  14.28471d0,   8.82845d0,  -5.45626d0 ]
    geom.iniP(41).pos(1:3) = [  14.28471d0,  -8.82845d0,  -5.45626d0 ]; geom.iniP(42).pos(1:3) = [  15.94015d0,   0.00000d0,  -9.85156d0 ]

    ! Set face connnectivity
    geom.face( 1).n_poi = 3; allocate(geom.face( 1).poi(3)); geom.face( 1).poi(1:3) = [  2, 33, 39 ]
    geom.face( 2).n_poi = 3; allocate(geom.face( 2).poi(3)); geom.face( 2).poi(1:3) = [ 42, 40, 39 ]
    geom.face( 3).n_poi = 3; allocate(geom.face( 3).poi(3)); geom.face( 3).poi(1:3) = [ 42, 36, 37 ]
    geom.face( 4).n_poi = 3; allocate(geom.face( 4).poi(3)); geom.face( 4).poi(1:3) = [ 42, 37, 40 ]
    geom.face( 5).n_poi = 3; allocate(geom.face( 5).poi(3)); geom.face( 5).poi(1:3) = [ 42, 41, 36 ]
    geom.face( 6).n_poi = 3; allocate(geom.face( 6).poi(3)); geom.face( 6).poi(1:3) = [  5, 32,  1 ]
    geom.face( 7).n_poi = 3; allocate(geom.face( 7).poi(3)); geom.face( 7).poi(1:3) = [ 16, 33, 31 ]
    geom.face( 8).n_poi = 3; allocate(geom.face( 8).poi(3)); geom.face( 8).poi(1:3) = [  2, 29, 35 ]
    geom.face( 9).n_poi = 3; allocate(geom.face( 9).poi(3)); geom.face( 9).poi(1:3) = [  9,  3,  4 ]
    geom.face(10).n_poi = 3; allocate(geom.face(10).poi(3)); geom.face(10).poi(1:3) = [ 26, 23,  4 ]
    geom.face(11).n_poi = 3; allocate(geom.face(11).poi(3)); geom.face(11).poi(1:3) = [  5,  1,  6 ]
    geom.face(12).n_poi = 3; allocate(geom.face(12).poi(3)); geom.face(12).poi(1:3) = [ 26, 25,  6 ]
    geom.face(13).n_poi = 3; allocate(geom.face(13).poi(3)); geom.face(13).poi(1:3) = [ 34, 24,  7 ]
    geom.face(14).n_poi = 3; allocate(geom.face(14).poi(3)); geom.face(14).poi(1:3) = [  8, 38, 21 ]
    geom.face(15).n_poi = 3; allocate(geom.face(15).poi(3)); geom.face(15).poi(1:3) = [  9, 27, 21 ]
    geom.face(16).n_poi = 3; allocate(geom.face(16).poi(3)); geom.face(16).poi(1:3) = [  9, 22,  3 ]
    geom.face(17).n_poi = 3; allocate(geom.face(17).poi(3)); geom.face(17).poi(1:3) = [  5, 10, 31 ]
    geom.face(18).n_poi = 3; allocate(geom.face(18).poi(3)); geom.face(18).poi(1:3) = [ 34, 28, 24 ]
    geom.face(19).n_poi = 3; allocate(geom.face(19).poi(3)); geom.face(19).poi(1:3) = [  8, 20, 14 ]
    geom.face(20).n_poi = 3; allocate(geom.face(20).poi(3)); geom.face(20).poi(1:3) = [ 18, 12, 19 ]
    geom.face(21).n_poi = 3; allocate(geom.face(21).poi(3)); geom.face(21).poi(1:3) = [ 19, 17, 11 ]
    geom.face(22).n_poi = 3; allocate(geom.face(22).poi(3)); geom.face(22).poi(1:3) = [ 17, 12, 16 ]
    geom.face(23).n_poi = 3; allocate(geom.face(23).poi(3)); geom.face(23).poi(1:3) = [ 19, 12, 17 ]
    geom.face(24).n_poi = 3; allocate(geom.face(24).poi(3)); geom.face(24).poi(1:3) = [ 14, 15, 30 ]
    geom.face(25).n_poi = 3; allocate(geom.face(25).poi(3)); geom.face(25).poi(1:3) = [ 15, 20, 13 ]
    geom.face(26).n_poi = 3; allocate(geom.face(26).poi(3)); geom.face(26).poi(1:3) = [ 14, 20, 15 ]
    geom.face(27).n_poi = 3; allocate(geom.face(27).poi(3)); geom.face(27).poi(1:3) = [ 24, 15, 13 ]
    geom.face(28).n_poi = 3; allocate(geom.face(28).poi(3)); geom.face(28).poi(1:3) = [ 15, 28, 30 ]
    geom.face(29).n_poi = 3; allocate(geom.face(29).poi(3)); geom.face(29).poi(1:3) = [ 24, 28, 15 ]
    geom.face(30).n_poi = 3; allocate(geom.face(30).poi(3)); geom.face(30).poi(1:3) = [ 31, 17, 16 ]
    geom.face(31).n_poi = 3; allocate(geom.face(31).poi(3)); geom.face(31).poi(1:3) = [ 17, 10, 11 ]
    geom.face(32).n_poi = 3; allocate(geom.face(32).poi(3)); geom.face(32).poi(1:3) = [ 31, 10, 17 ]
    geom.face(33).n_poi = 3; allocate(geom.face(33).poi(3)); geom.face(33).poi(1:3) = [  3, 19, 11 ]
    geom.face(34).n_poi = 3; allocate(geom.face(34).poi(3)); geom.face(34).poi(1:3) = [ 19, 22, 18 ]
    geom.face(35).n_poi = 3; allocate(geom.face(35).poi(3)); geom.face(35).poi(1:3) = [  3, 22, 19 ]
    geom.face(36).n_poi = 3; allocate(geom.face(36).poi(3)); geom.face(36).poi(1:3) = [ 21, 20,  8 ]
    geom.face(37).n_poi = 3; allocate(geom.face(37).poi(3)); geom.face(37).poi(1:3) = [ 20, 27, 13 ]
    geom.face(38).n_poi = 3; allocate(geom.face(38).poi(3)); geom.face(38).poi(1:3) = [ 21, 27, 20 ]
    geom.face(39).n_poi = 3; allocate(geom.face(39).poi(3)); geom.face(39).poi(1:3) = [ 21, 22,  9 ]
    geom.face(40).n_poi = 3; allocate(geom.face(40).poi(3)); geom.face(40).poi(1:3) = [ 22, 38, 18 ]
    geom.face(41).n_poi = 3; allocate(geom.face(41).poi(3)); geom.face(41).poi(1:3) = [ 21, 38, 22 ]
    geom.face(42).n_poi = 3; allocate(geom.face(42).poi(3)); geom.face(42).poi(1:3) = [  7, 23, 26 ]
    geom.face(43).n_poi = 3; allocate(geom.face(43).poi(3)); geom.face(43).poi(1:3) = [ 23, 24, 13 ]
    geom.face(44).n_poi = 3; allocate(geom.face(44).poi(3)); geom.face(44).poi(1:3) = [  7, 24, 23 ]
    geom.face(45).n_poi = 3; allocate(geom.face(45).poi(3)); geom.face(45).poi(1:3) = [  6, 10,  5 ]
    geom.face(46).n_poi = 3; allocate(geom.face(46).poi(3)); geom.face(46).poi(1:3) = [ 10, 25, 11 ]
    geom.face(47).n_poi = 3; allocate(geom.face(47).poi(3)); geom.face(47).poi(1:3) = [  6, 25, 10 ]
    geom.face(48).n_poi = 3; allocate(geom.face(48).poi(3)); geom.face(48).poi(1:3) = [  6,  7, 26 ]
    geom.face(49).n_poi = 3; allocate(geom.face(49).poi(3)); geom.face(49).poi(1:3) = [  7,  1, 34 ]
    geom.face(50).n_poi = 3; allocate(geom.face(50).poi(3)); geom.face(50).poi(1:3) = [  6,  1,  7 ]
    geom.face(51).n_poi = 3; allocate(geom.face(51).poi(3)); geom.face(51).poi(1:3) = [  4, 27,  9 ]
    geom.face(52).n_poi = 3; allocate(geom.face(52).poi(3)); geom.face(52).poi(1:3) = [ 27, 23, 13 ]
    geom.face(53).n_poi = 3; allocate(geom.face(53).poi(3)); geom.face(53).poi(1:3) = [  4, 23, 27 ]
    geom.face(54).n_poi = 3; allocate(geom.face(54).poi(3)); geom.face(54).poi(1:3) = [  4, 25, 26 ]
    geom.face(55).n_poi = 3; allocate(geom.face(55).poi(3)); geom.face(55).poi(1:3) = [ 25,  3, 11 ]
    geom.face(56).n_poi = 3; allocate(geom.face(56).poi(3)); geom.face(56).poi(1:3) = [  4,  3, 25 ]
    geom.face(57).n_poi = 3; allocate(geom.face(57).poi(3)); geom.face(57).poi(1:3) = [ 35, 28, 34 ]
    geom.face(58).n_poi = 3; allocate(geom.face(58).poi(3)); geom.face(58).poi(1:3) = [ 28, 29, 30 ]
    geom.face(59).n_poi = 3; allocate(geom.face(59).poi(3)); geom.face(59).poi(1:3) = [ 35, 29, 28 ]
    geom.face(60).n_poi = 3; allocate(geom.face(60).poi(3)); geom.face(60).poi(1:3) = [ 31, 32,  5 ]
    geom.face(61).n_poi = 3; allocate(geom.face(61).poi(3)); geom.face(61).poi(1:3) = [ 32, 33,  2 ]
    geom.face(62).n_poi = 3; allocate(geom.face(62).poi(3)); geom.face(62).poi(1:3) = [ 31, 33, 32 ]
    geom.face(63).n_poi = 3; allocate(geom.face(63).poi(3)); geom.face(63).poi(1:3) = [  1, 35, 34 ]
    geom.face(64).n_poi = 3; allocate(geom.face(64).poi(3)); geom.face(64).poi(1:3) = [ 35, 32,  2 ]
    geom.face(65).n_poi = 3; allocate(geom.face(65).poi(3)); geom.face(65).poi(1:3) = [  1, 32, 35 ]
    geom.face(66).n_poi = 3; allocate(geom.face(66).poi(3)); geom.face(66).poi(1:3) = [ 36, 12, 18 ]
    geom.face(67).n_poi = 3; allocate(geom.face(67).poi(3)); geom.face(67).poi(1:3) = [ 12, 41, 16 ]
    geom.face(68).n_poi = 3; allocate(geom.face(68).poi(3)); geom.face(68).poi(1:3) = [ 36, 41, 12 ]
    geom.face(69).n_poi = 3; allocate(geom.face(69).poi(3)); geom.face(69).poi(1:3) = [ 40, 14, 30 ]
    geom.face(70).n_poi = 3; allocate(geom.face(70).poi(3)); geom.face(70).poi(1:3) = [ 14, 37,  8 ]
    geom.face(71).n_poi = 3; allocate(geom.face(71).poi(3)); geom.face(71).poi(1:3) = [ 40, 37, 14 ]
    geom.face(72).n_poi = 3; allocate(geom.face(72).poi(3)); geom.face(72).poi(1:3) = [ 37, 38,  8 ]
    geom.face(73).n_poi = 3; allocate(geom.face(73).poi(3)); geom.face(73).poi(1:3) = [ 38, 36, 18 ]
    geom.face(74).n_poi = 3; allocate(geom.face(74).poi(3)); geom.face(74).poi(1:3) = [ 37, 36, 38 ]
    geom.face(75).n_poi = 3; allocate(geom.face(75).poi(3)); geom.face(75).poi(1:3) = [ 39, 29,  2 ]
    geom.face(76).n_poi = 3; allocate(geom.face(76).poi(3)); geom.face(76).poi(1:3) = [ 29, 40, 30 ]
    geom.face(77).n_poi = 3; allocate(geom.face(77).poi(3)); geom.face(77).poi(1:3) = [ 39, 40, 29 ]
    geom.face(78).n_poi = 3; allocate(geom.face(78).poi(3)); geom.face(78).poi(1:3) = [ 39, 41, 42 ]
    geom.face(79).n_poi = 3; allocate(geom.face(79).poi(3)); geom.face(79).poi(1:3) = [ 41, 33, 16 ]
    geom.face(80).n_poi = 3; allocate(geom.face(80).poi(3)); geom.face(80).poi(1:3) = [ 39, 33, 41 ]
end subroutine Exam_Asym_Ball

! -----------------------------------------------------------------------------

! Example of Nickedtorus
subroutine Exam_Asym_Nickedtorus(prob, geom)
    type(ProbType), intent(inout) :: prob
    type(GeomType), intent(inout) :: geom

    character(10) :: char_sec, char_bp, char_start_bp

    write(unit=char_sec,      fmt = "(i10)"), prob.sel_sec
    write(unit=char_bp,       fmt = "(i10)"), prob.n_bp_edge
    write(unit=char_start_bp, fmt = "(i10)"), para_start_bp_ID

    prob.name_prob = "Nickedtorus"
    prob.name_file = "Nickedtorus"//&
        "_"//trim(adjustl(trim(char_sec)))//"cs"//&
        "_"//trim(adjustl(trim(char_bp)))//"bp"//&
        "_"//trim(para_vertex_design)

    ! Problem specified preset parameters
    if(para_vertex_design == "flat" .and. para_preset == "on") then
        para_junc_ang        = "max"    ! Junction gap modification for different arm angle
        para_const_edge_mesh = "off"    ! Constant edge length from polyhedra mesh
        para_unpaired_scaf   = "off"    ! Unpaired scaffold nucleotides
        para_n_base_tn       = 7
    end if

    ! Set geometric type and view (atom, cylinder size, move_x, move_y)
    call Mani_Set_View_Color(prob, [195, 153, 107], "xz")

    ! Allocate point and face structure
    geom.n_iniP = 98
    geom.n_face = 192

    allocate(geom.iniP(geom.n_iniP))
    allocate(geom.face(geom.n_face))

    ! Set point position vectors
    geom.iniP(  1).pos(1:3) = [   9.12070d0,   0.00000d0, -17.26891d0 ]; geom.iniP(  2).pos(1:3) = [  16.19178d0,   0.00000d0, -10.19782d0 ]
    geom.iniP(  3).pos(1:3) = [  11.94982d0,  13.66024d0, -22.16909d0 ]; geom.iniP(  4).pos(1:3) = [  21.09196d0,  13.66024d0, -13.02694d0 ]
    geom.iniP(  5).pos(1:3) = [  -0.53856d0,   0.00000d0, -19.85709d0 ]; geom.iniP(  6).pos(1:3) = [  -0.53856d0,  13.66024d0, -25.51536d0 ]
    geom.iniP(  7).pos(1:3) = [ -10.19782d0,   0.00000d0, -17.26891d0 ]; geom.iniP(  8).pos(1:3) = [ -13.02694d0,  13.66024d0, -22.16909d0 ]
    geom.iniP(  9).pos(1:3) = [ -17.26891d0,   0.00000d0, -10.19782d0 ]; geom.iniP( 10).pos(1:3) = [ -22.16909d0,  13.66024d0, -13.02694d0 ]
    geom.iniP( 11).pos(1:3) = [ -19.85709d0,   0.00000d0,  -0.53856d0 ]; geom.iniP( 12).pos(1:3) = [ -25.51536d0,  13.66024d0,  -0.53856d0 ]
    geom.iniP( 13).pos(1:3) = [ -17.26891d0,   0.00000d0,   9.12070d0 ]; geom.iniP( 14).pos(1:3) = [ -22.16909d0,  13.66024d0,  11.94982d0 ]
    geom.iniP( 15).pos(1:3) = [ -10.19782d0,   0.00000d0,  16.19178d0 ]; geom.iniP( 16).pos(1:3) = [ -13.02694d0,  13.66024d0,  21.09196d0 ]
    geom.iniP( 17).pos(1:3) = [  -0.53856d0,   0.00000d0,  18.77996d0 ]; geom.iniP( 18).pos(1:3) = [  -0.53856d0,  13.66024d0,  24.43824d0 ]
    geom.iniP( 19).pos(1:3) = [   9.12070d0,   0.00000d0,  16.19178d0 ]; geom.iniP( 20).pos(1:3) = [  11.94982d0,  13.66024d0,  21.09196d0 ]
    geom.iniP( 21).pos(1:3) = [  18.77996d0,   0.00000d0,  -0.53856d0 ]; geom.iniP( 22).pos(1:3) = [  16.19178d0,   0.00000d0,   9.12070d0 ]
    geom.iniP( 23).pos(1:3) = [  24.43824d0,  13.66024d0,  -0.53856d0 ]; geom.iniP( 24).pos(1:3) = [  21.09196d0,  13.66024d0,  11.94982d0 ]
    geom.iniP( 25).pos(1:3) = [  18.77996d0,  19.31852d0, -33.99921d0 ]; geom.iniP( 26).pos(1:3) = [  32.92208d0,  19.31852d0, -19.85709d0 ]
    geom.iniP( 27).pos(1:3) = [  -0.53856d0,  19.31852d0, -39.17561d0 ]; geom.iniP( 28).pos(1:3) = [ -19.85709d0,  19.31852d0, -33.99921d0 ]
    geom.iniP( 29).pos(1:3) = [ -33.99921d0,  19.31852d0, -19.85709d0 ]; geom.iniP( 30).pos(1:3) = [ -39.17561d0,  19.31852d0,  -0.53856d0 ]
    geom.iniP( 31).pos(1:3) = [ -33.99921d0,  19.31852d0,  18.77996d0 ]; geom.iniP( 32).pos(1:3) = [ -19.85709d0,  19.31852d0,  32.92208d0 ]
    geom.iniP( 33).pos(1:3) = [  -0.53856d0,  19.31852d0,  38.09848d0 ]; geom.iniP( 34).pos(1:3) = [  18.77996d0,  19.31852d0,  32.92208d0 ]
    geom.iniP( 35).pos(1:3) = [  38.09848d0,  19.31852d0,  -0.53856d0 ]; geom.iniP( 36).pos(1:3) = [  32.92208d0,  19.31852d0,  18.77996d0 ]
    geom.iniP( 37).pos(1:3) = [  25.61010d0,  13.66024d0, -45.82929d0 ]; geom.iniP( 38).pos(1:3) = [  44.75217d0,  13.66024d0, -26.68723d0 ]
    geom.iniP( 39).pos(1:3) = [  -0.53856d0,  13.66024d0, -52.83573d0 ]; geom.iniP( 40).pos(1:3) = [ -26.68723d0,  13.66024d0, -45.82929d0 ]
    geom.iniP( 41).pos(1:3) = [ -45.82929d0,  13.66024d0, -26.68723d0 ]; geom.iniP( 42).pos(1:3) = [ -52.83573d0,  13.66024d0,  -0.53856d0 ]
    geom.iniP( 43).pos(1:3) = [ -45.82929d0,  13.66024d0,  25.61010d0 ]; geom.iniP( 44).pos(1:3) = [ -26.68723d0,  13.66024d0,  44.75217d0 ]
    geom.iniP( 45).pos(1:3) = [  -0.53856d0,  13.66024d0,  51.75861d0 ]; geom.iniP( 46).pos(1:3) = [  25.61010d0,  13.66024d0,  44.75217d0 ]
    geom.iniP( 47).pos(1:3) = [  51.75861d0,  13.66024d0,  -0.53856d0 ]; geom.iniP( 48).pos(1:3) = [  44.75217d0,  13.66024d0,  25.61010d0 ]
    geom.iniP( 49).pos(1:3) = [  28.43922d0,   0.00000d0, -50.72963d0 ]; geom.iniP( 50).pos(1:3) = [  49.65250d0,   0.00000d0, -29.51635d0 ]
    geom.iniP( 51).pos(1:3) = [  -0.53856d0,   0.00000d0, -58.49413d0 ]; geom.iniP( 52).pos(1:3) = [ -29.51635d0,   0.00000d0, -50.72963d0 ]
    geom.iniP( 53).pos(1:3) = [ -50.72963d0,   0.00000d0, -29.51635d0 ]; geom.iniP( 54).pos(1:3) = [ -58.49413d0,   0.00000d0,  -0.53856d0 ]
    geom.iniP( 55).pos(1:3) = [ -50.72963d0,   0.00000d0,  28.43922d0 ]; geom.iniP( 56).pos(1:3) = [ -29.51635d0,   0.00000d0,  49.65250d0 ]
    geom.iniP( 57).pos(1:3) = [  -0.53856d0,   0.00000d0,  57.41700d0 ]; geom.iniP( 58).pos(1:3) = [  28.43922d0,   0.00000d0,  49.65250d0 ]
    geom.iniP( 59).pos(1:3) = [  57.41700d0,   0.00000d0,  -0.53856d0 ]; geom.iniP( 60).pos(1:3) = [  49.65250d0,   0.00000d0,  28.43922d0 ]
    geom.iniP( 61).pos(1:3) = [  25.61010d0, -13.66024d0, -45.82929d0 ]; geom.iniP( 62).pos(1:3) = [  44.75217d0, -13.66024d0, -26.68723d0 ]
    geom.iniP( 63).pos(1:3) = [  -0.53856d0, -13.66024d0, -52.83573d0 ]; geom.iniP( 64).pos(1:3) = [ -26.68723d0, -13.66024d0, -45.82929d0 ]
    geom.iniP( 65).pos(1:3) = [ -45.82929d0, -13.66024d0, -26.68723d0 ]; geom.iniP( 66).pos(1:3) = [ -52.83573d0, -13.66024d0,  -0.53856d0 ]
    geom.iniP( 67).pos(1:3) = [ -45.82929d0, -13.66024d0,  25.61010d0 ]; geom.iniP( 68).pos(1:3) = [ -26.68723d0, -13.66024d0,  44.75217d0 ]
    geom.iniP( 69).pos(1:3) = [  -0.53856d0, -13.66024d0,  51.75861d0 ]; geom.iniP( 70).pos(1:3) = [  25.61010d0, -13.66024d0,  44.75217d0 ]
    geom.iniP( 71).pos(1:3) = [  51.75861d0, -13.66024d0,  -0.53856d0 ]; geom.iniP( 72).pos(1:3) = [  44.75217d0, -13.66024d0,  25.61010d0 ]
    geom.iniP( 73).pos(1:3) = [  18.77996d0, -19.31852d0, -33.99921d0 ]; geom.iniP( 74).pos(1:3) = [  32.92208d0, -19.31852d0, -19.85709d0 ]
    geom.iniP( 75).pos(1:3) = [  -0.53856d0, -19.31852d0, -39.17561d0 ]; geom.iniP( 76).pos(1:3) = [ -19.85709d0, -19.31852d0, -33.99921d0 ]
    geom.iniP( 77).pos(1:3) = [ -33.99921d0, -19.31852d0, -19.85709d0 ]; geom.iniP( 78).pos(1:3) = [ -39.17561d0, -19.31852d0,  -0.53856d0 ]
    geom.iniP( 79).pos(1:3) = [ -33.99921d0, -19.31852d0,  18.77996d0 ]; geom.iniP( 80).pos(1:3) = [ -19.85709d0, -19.31852d0,  32.92208d0 ]
    geom.iniP( 81).pos(1:3) = [  -0.53856d0, -19.31852d0,  38.09848d0 ]; geom.iniP( 82).pos(1:3) = [  18.77996d0, -19.31852d0,  32.92208d0 ]
    geom.iniP( 83).pos(1:3) = [  38.09848d0, -19.31852d0,  -0.53856d0 ]; geom.iniP( 84).pos(1:3) = [  32.92208d0, -19.31852d0,  18.77996d0 ]
    geom.iniP( 85).pos(1:3) = [  11.94982d0, -13.66024d0, -22.16909d0 ]; geom.iniP( 86).pos(1:3) = [  21.09196d0, -13.66024d0, -13.02694d0 ]
    geom.iniP( 87).pos(1:3) = [  -0.53856d0, -13.66024d0, -25.51536d0 ]; geom.iniP( 88).pos(1:3) = [ -13.02694d0, -13.66024d0, -22.16909d0 ]
    geom.iniP( 89).pos(1:3) = [ -22.16909d0, -13.66024d0, -13.02694d0 ]; geom.iniP( 90).pos(1:3) = [ -25.51536d0, -13.66024d0,  -0.53856d0 ]
    geom.iniP( 91).pos(1:3) = [ -22.16909d0, -13.66024d0,  11.94982d0 ]; geom.iniP( 92).pos(1:3) = [ -13.02694d0, -13.66024d0,  21.09196d0 ]
    geom.iniP( 93).pos(1:3) = [  -0.53856d0, -13.66024d0,  24.43824d0 ]; geom.iniP( 94).pos(1:3) = [  11.94982d0, -13.66024d0,  21.09196d0 ]
    geom.iniP( 95).pos(1:3) = [  24.43824d0, -13.66024d0,  -0.53856d0 ]; geom.iniP( 96).pos(1:3) = [  21.09196d0, -13.66024d0,  11.94982d0 ]
    geom.iniP( 97).pos(1:3) = [  18.77996d0,   0.00000d0,  32.92208d0 ]; geom.iniP( 98).pos(1:3) = [  32.92208d0,   0.00000d0,  18.77996d0 ]

    ! Set face connnectivity
    geom.face(  1).n_poi = 3; allocate(geom.face(  1).poi(3)); geom.face(  1).poi(1:3) = [  1,   2,   3 ]
    geom.face(  2).n_poi = 3; allocate(geom.face(  2).poi(3)); geom.face(  2).poi(1:3) = [  3,   2,   4 ]
    geom.face(  3).n_poi = 3; allocate(geom.face(  3).poi(3)); geom.face(  3).poi(1:3) = [  5,   1,   6 ]
    geom.face(  4).n_poi = 3; allocate(geom.face(  4).poi(3)); geom.face(  4).poi(1:3) = [  6,   1,   3 ]
    geom.face(  5).n_poi = 3; allocate(geom.face(  5).poi(3)); geom.face(  5).poi(1:3) = [  7,   5,   8 ]
    geom.face(  6).n_poi = 3; allocate(geom.face(  6).poi(3)); geom.face(  6).poi(1:3) = [  8,   5,   6 ]
    geom.face(  7).n_poi = 3; allocate(geom.face(  7).poi(3)); geom.face(  7).poi(1:3) = [  9,   7,  10 ]
    geom.face(  8).n_poi = 3; allocate(geom.face(  8).poi(3)); geom.face(  8).poi(1:3) = [ 10,   7,   8 ]
    geom.face(  9).n_poi = 3; allocate(geom.face(  9).poi(3)); geom.face(  9).poi(1:3) = [ 11,   9,  12 ]
    geom.face( 10).n_poi = 3; allocate(geom.face( 10).poi(3)); geom.face( 10).poi(1:3) = [ 12,   9,  10 ]
    geom.face( 11).n_poi = 3; allocate(geom.face( 11).poi(3)); geom.face( 11).poi(1:3) = [ 13,  11,  14 ]
    geom.face( 12).n_poi = 3; allocate(geom.face( 12).poi(3)); geom.face( 12).poi(1:3) = [ 14,  11,  12 ]
    geom.face( 13).n_poi = 3; allocate(geom.face( 13).poi(3)); geom.face( 13).poi(1:3) = [ 15,  13,  16 ]
    geom.face( 14).n_poi = 3; allocate(geom.face( 14).poi(3)); geom.face( 14).poi(1:3) = [ 16,  13,  14 ]
    geom.face( 15).n_poi = 3; allocate(geom.face( 15).poi(3)); geom.face( 15).poi(1:3) = [ 17,  15,  18 ]
    geom.face( 16).n_poi = 3; allocate(geom.face( 16).poi(3)); geom.face( 16).poi(1:3) = [ 18,  15,  16 ]
    geom.face( 17).n_poi = 3; allocate(geom.face( 17).poi(3)); geom.face( 17).poi(1:3) = [ 19,  17,  20 ]
    geom.face( 18).n_poi = 3; allocate(geom.face( 18).poi(3)); geom.face( 18).poi(1:3) = [ 20,  17,  18 ]
    geom.face( 19).n_poi = 3; allocate(geom.face( 19).poi(3)); geom.face( 19).poi(1:3) = [ 21,  22,  23 ]
    geom.face( 20).n_poi = 3; allocate(geom.face( 20).poi(3)); geom.face( 20).poi(1:3) = [ 23,  22,  24 ]
    geom.face( 21).n_poi = 3; allocate(geom.face( 21).poi(3)); geom.face( 21).poi(1:3) = [  2,  21,   4 ]
    geom.face( 22).n_poi = 3; allocate(geom.face( 22).poi(3)); geom.face( 22).poi(1:3) = [  4,  21,  23 ]
    geom.face( 23).n_poi = 3; allocate(geom.face( 23).poi(3)); geom.face( 23).poi(1:3) = [  3,   4,  25 ]
    geom.face( 24).n_poi = 3; allocate(geom.face( 24).poi(3)); geom.face( 24).poi(1:3) = [ 25,   4,  26 ]
    geom.face( 25).n_poi = 3; allocate(geom.face( 25).poi(3)); geom.face( 25).poi(1:3) = [  6,   3,  27 ]
    geom.face( 26).n_poi = 3; allocate(geom.face( 26).poi(3)); geom.face( 26).poi(1:3) = [ 27,   3,  25 ]
    geom.face( 27).n_poi = 3; allocate(geom.face( 27).poi(3)); geom.face( 27).poi(1:3) = [  8,   6,  28 ]
    geom.face( 28).n_poi = 3; allocate(geom.face( 28).poi(3)); geom.face( 28).poi(1:3) = [ 28,   6,  27 ]
    geom.face( 29).n_poi = 3; allocate(geom.face( 29).poi(3)); geom.face( 29).poi(1:3) = [ 10,   8,  29 ]
    geom.face( 30).n_poi = 3; allocate(geom.face( 30).poi(3)); geom.face( 30).poi(1:3) = [ 29,   8,  28 ]
    geom.face( 31).n_poi = 3; allocate(geom.face( 31).poi(3)); geom.face( 31).poi(1:3) = [ 12,  10,  30 ]
    geom.face( 32).n_poi = 3; allocate(geom.face( 32).poi(3)); geom.face( 32).poi(1:3) = [ 30,  10,  29 ]
    geom.face( 33).n_poi = 3; allocate(geom.face( 33).poi(3)); geom.face( 33).poi(1:3) = [ 14,  12,  31 ]
    geom.face( 34).n_poi = 3; allocate(geom.face( 34).poi(3)); geom.face( 34).poi(1:3) = [ 31,  12,  30 ]
    geom.face( 35).n_poi = 3; allocate(geom.face( 35).poi(3)); geom.face( 35).poi(1:3) = [ 16,  14,  32 ]
    geom.face( 36).n_poi = 3; allocate(geom.face( 36).poi(3)); geom.face( 36).poi(1:3) = [ 32,  14,  31 ]
    geom.face( 37).n_poi = 3; allocate(geom.face( 37).poi(3)); geom.face( 37).poi(1:3) = [ 18,  16,  33 ]
    geom.face( 38).n_poi = 3; allocate(geom.face( 38).poi(3)); geom.face( 38).poi(1:3) = [ 33,  16,  32 ]
    geom.face( 39).n_poi = 3; allocate(geom.face( 39).poi(3)); geom.face( 39).poi(1:3) = [ 20,  18,  34 ]
    geom.face( 40).n_poi = 3; allocate(geom.face( 40).poi(3)); geom.face( 40).poi(1:3) = [ 34,  18,  33 ]
    geom.face( 41).n_poi = 3; allocate(geom.face( 41).poi(3)); geom.face( 41).poi(1:3) = [ 23,  24,  35 ]
    geom.face( 42).n_poi = 3; allocate(geom.face( 42).poi(3)); geom.face( 42).poi(1:3) = [ 35,  24,  36 ]
    geom.face( 43).n_poi = 3; allocate(geom.face( 43).poi(3)); geom.face( 43).poi(1:3) = [  4,  23,  26 ]
    geom.face( 44).n_poi = 3; allocate(geom.face( 44).poi(3)); geom.face( 44).poi(1:3) = [ 26,  23,  35 ]
    geom.face( 45).n_poi = 3; allocate(geom.face( 45).poi(3)); geom.face( 45).poi(1:3) = [ 25,  26,  37 ]
    geom.face( 46).n_poi = 3; allocate(geom.face( 46).poi(3)); geom.face( 46).poi(1:3) = [ 37,  26,  38 ]
    geom.face( 47).n_poi = 3; allocate(geom.face( 47).poi(3)); geom.face( 47).poi(1:3) = [ 27,  25,  39 ]
    geom.face( 48).n_poi = 3; allocate(geom.face( 48).poi(3)); geom.face( 48).poi(1:3) = [ 39,  25,  37 ]
    geom.face( 49).n_poi = 3; allocate(geom.face( 49).poi(3)); geom.face( 49).poi(1:3) = [ 28,  27,  40 ]
    geom.face( 50).n_poi = 3; allocate(geom.face( 50).poi(3)); geom.face( 50).poi(1:3) = [ 40,  27,  39 ]
    geom.face( 51).n_poi = 3; allocate(geom.face( 51).poi(3)); geom.face( 51).poi(1:3) = [ 29,  28,  41 ]
    geom.face( 52).n_poi = 3; allocate(geom.face( 52).poi(3)); geom.face( 52).poi(1:3) = [ 41,  28,  40 ]
    geom.face( 53).n_poi = 3; allocate(geom.face( 53).poi(3)); geom.face( 53).poi(1:3) = [ 30,  29,  42 ]
    geom.face( 54).n_poi = 3; allocate(geom.face( 54).poi(3)); geom.face( 54).poi(1:3) = [ 42,  29,  41 ]
    geom.face( 55).n_poi = 3; allocate(geom.face( 55).poi(3)); geom.face( 55).poi(1:3) = [ 31,  30,  43 ]
    geom.face( 56).n_poi = 3; allocate(geom.face( 56).poi(3)); geom.face( 56).poi(1:3) = [ 43,  30,  42 ]
    geom.face( 57).n_poi = 3; allocate(geom.face( 57).poi(3)); geom.face( 57).poi(1:3) = [ 32,  31,  44 ]
    geom.face( 58).n_poi = 3; allocate(geom.face( 58).poi(3)); geom.face( 58).poi(1:3) = [ 44,  31,  43 ]
    geom.face( 59).n_poi = 3; allocate(geom.face( 59).poi(3)); geom.face( 59).poi(1:3) = [ 33,  32,  45 ]
    geom.face( 60).n_poi = 3; allocate(geom.face( 60).poi(3)); geom.face( 60).poi(1:3) = [ 45,  32,  44 ]
    geom.face( 61).n_poi = 3; allocate(geom.face( 61).poi(3)); geom.face( 61).poi(1:3) = [ 34,  33,  46 ]
    geom.face( 62).n_poi = 3; allocate(geom.face( 62).poi(3)); geom.face( 62).poi(1:3) = [ 46,  33,  45 ]
    geom.face( 63).n_poi = 3; allocate(geom.face( 63).poi(3)); geom.face( 63).poi(1:3) = [ 35,  36,  47 ]
    geom.face( 64).n_poi = 3; allocate(geom.face( 64).poi(3)); geom.face( 64).poi(1:3) = [ 47,  36,  48 ]
    geom.face( 65).n_poi = 3; allocate(geom.face( 65).poi(3)); geom.face( 65).poi(1:3) = [ 26,  35,  38 ]
    geom.face( 66).n_poi = 3; allocate(geom.face( 66).poi(3)); geom.face( 66).poi(1:3) = [ 38,  35,  47 ]
    geom.face( 67).n_poi = 3; allocate(geom.face( 67).poi(3)); geom.face( 67).poi(1:3) = [ 37,  38,  49 ]
    geom.face( 68).n_poi = 3; allocate(geom.face( 68).poi(3)); geom.face( 68).poi(1:3) = [ 49,  38,  50 ]
    geom.face( 69).n_poi = 3; allocate(geom.face( 69).poi(3)); geom.face( 69).poi(1:3) = [ 39,  37,  51 ]
    geom.face( 70).n_poi = 3; allocate(geom.face( 70).poi(3)); geom.face( 70).poi(1:3) = [ 51,  37,  49 ]
    geom.face( 71).n_poi = 3; allocate(geom.face( 71).poi(3)); geom.face( 71).poi(1:3) = [ 40,  39,  52 ]
    geom.face( 72).n_poi = 3; allocate(geom.face( 72).poi(3)); geom.face( 72).poi(1:3) = [ 52,  39,  51 ]
    geom.face( 73).n_poi = 3; allocate(geom.face( 73).poi(3)); geom.face( 73).poi(1:3) = [ 41,  40,  53 ]
    geom.face( 74).n_poi = 3; allocate(geom.face( 74).poi(3)); geom.face( 74).poi(1:3) = [ 53,  40,  52 ]
    geom.face( 75).n_poi = 3; allocate(geom.face( 75).poi(3)); geom.face( 75).poi(1:3) = [ 42,  41,  54 ]
    geom.face( 76).n_poi = 3; allocate(geom.face( 76).poi(3)); geom.face( 76).poi(1:3) = [ 54,  41,  53 ]
    geom.face( 77).n_poi = 3; allocate(geom.face( 77).poi(3)); geom.face( 77).poi(1:3) = [ 43,  42,  55 ]
    geom.face( 78).n_poi = 3; allocate(geom.face( 78).poi(3)); geom.face( 78).poi(1:3) = [ 55,  42,  54 ]
    geom.face( 79).n_poi = 3; allocate(geom.face( 79).poi(3)); geom.face( 79).poi(1:3) = [ 44,  43,  56 ]
    geom.face( 80).n_poi = 3; allocate(geom.face( 80).poi(3)); geom.face( 80).poi(1:3) = [ 56,  43,  55 ]
    geom.face( 81).n_poi = 3; allocate(geom.face( 81).poi(3)); geom.face( 81).poi(1:3) = [ 45,  44,  57 ]
    geom.face( 82).n_poi = 3; allocate(geom.face( 82).poi(3)); geom.face( 82).poi(1:3) = [ 57,  44,  56 ]
    geom.face( 83).n_poi = 3; allocate(geom.face( 83).poi(3)); geom.face( 83).poi(1:3) = [ 46,  45,  58 ]
    geom.face( 84).n_poi = 3; allocate(geom.face( 84).poi(3)); geom.face( 84).poi(1:3) = [ 58,  45,  57 ]
    geom.face( 85).n_poi = 3; allocate(geom.face( 85).poi(3)); geom.face( 85).poi(1:3) = [ 47,  48,  59 ]
    geom.face( 86).n_poi = 3; allocate(geom.face( 86).poi(3)); geom.face( 86).poi(1:3) = [ 59,  48,  60 ]
    geom.face( 87).n_poi = 3; allocate(geom.face( 87).poi(3)); geom.face( 87).poi(1:3) = [ 38,  47,  50 ]
    geom.face( 88).n_poi = 3; allocate(geom.face( 88).poi(3)); geom.face( 88).poi(1:3) = [ 50,  47,  59 ]
    geom.face( 89).n_poi = 3; allocate(geom.face( 89).poi(3)); geom.face( 89).poi(1:3) = [ 49,  50,  61 ]
    geom.face( 90).n_poi = 3; allocate(geom.face( 90).poi(3)); geom.face( 90).poi(1:3) = [ 61,  50,  62 ]
    geom.face( 91).n_poi = 3; allocate(geom.face( 91).poi(3)); geom.face( 91).poi(1:3) = [ 51,  49,  63 ]
    geom.face( 92).n_poi = 3; allocate(geom.face( 92).poi(3)); geom.face( 92).poi(1:3) = [ 63,  49,  61 ]
    geom.face( 93).n_poi = 3; allocate(geom.face( 93).poi(3)); geom.face( 93).poi(1:3) = [ 52,  51,  64 ]
    geom.face( 94).n_poi = 3; allocate(geom.face( 94).poi(3)); geom.face( 94).poi(1:3) = [ 64,  51,  63 ]
    geom.face( 95).n_poi = 3; allocate(geom.face( 95).poi(3)); geom.face( 95).poi(1:3) = [ 53,  52,  65 ]
    geom.face( 96).n_poi = 3; allocate(geom.face( 96).poi(3)); geom.face( 96).poi(1:3) = [ 65,  52,  64 ]
    geom.face( 97).n_poi = 3; allocate(geom.face( 97).poi(3)); geom.face( 97).poi(1:3) = [ 54,  53,  66 ]
    geom.face( 98).n_poi = 3; allocate(geom.face( 98).poi(3)); geom.face( 98).poi(1:3) = [ 66,  53,  65 ]
    geom.face( 99).n_poi = 3; allocate(geom.face( 99).poi(3)); geom.face( 99).poi(1:3) = [ 55,  54,  67 ]
    geom.face(100).n_poi = 3; allocate(geom.face(100).poi(3)); geom.face(100).poi(1:3) = [ 67,  54,  66 ]
    geom.face(101).n_poi = 3; allocate(geom.face(101).poi(3)); geom.face(101).poi(1:3) = [ 56,  55,  68 ]
    geom.face(102).n_poi = 3; allocate(geom.face(102).poi(3)); geom.face(102).poi(1:3) = [ 68,  55,  67 ]
    geom.face(103).n_poi = 3; allocate(geom.face(103).poi(3)); geom.face(103).poi(1:3) = [ 57,  56,  69 ]
    geom.face(104).n_poi = 3; allocate(geom.face(104).poi(3)); geom.face(104).poi(1:3) = [ 69,  56,  68 ]
    geom.face(105).n_poi = 3; allocate(geom.face(105).poi(3)); geom.face(105).poi(1:3) = [ 58,  57,  70 ]
    geom.face(106).n_poi = 3; allocate(geom.face(106).poi(3)); geom.face(106).poi(1:3) = [ 70,  57,  69 ]
    geom.face(107).n_poi = 3; allocate(geom.face(107).poi(3)); geom.face(107).poi(1:3) = [ 59,  60,  71 ]
    geom.face(108).n_poi = 3; allocate(geom.face(108).poi(3)); geom.face(108).poi(1:3) = [ 71,  60,  72 ]
    geom.face(109).n_poi = 3; allocate(geom.face(109).poi(3)); geom.face(109).poi(1:3) = [ 50,  59,  62 ]
    geom.face(110).n_poi = 3; allocate(geom.face(110).poi(3)); geom.face(110).poi(1:3) = [ 62,  59,  71 ]
    geom.face(111).n_poi = 3; allocate(geom.face(111).poi(3)); geom.face(111).poi(1:3) = [ 61,  62,  73 ]
    geom.face(112).n_poi = 3; allocate(geom.face(112).poi(3)); geom.face(112).poi(1:3) = [ 73,  62,  74 ]
    geom.face(113).n_poi = 3; allocate(geom.face(113).poi(3)); geom.face(113).poi(1:3) = [ 63,  61,  75 ]
    geom.face(114).n_poi = 3; allocate(geom.face(114).poi(3)); geom.face(114).poi(1:3) = [ 75,  61,  73 ]
    geom.face(115).n_poi = 3; allocate(geom.face(115).poi(3)); geom.face(115).poi(1:3) = [ 64,  63,  76 ]
    geom.face(116).n_poi = 3; allocate(geom.face(116).poi(3)); geom.face(116).poi(1:3) = [ 76,  63,  75 ]
    geom.face(117).n_poi = 3; allocate(geom.face(117).poi(3)); geom.face(117).poi(1:3) = [ 65,  64,  77 ]
    geom.face(118).n_poi = 3; allocate(geom.face(118).poi(3)); geom.face(118).poi(1:3) = [ 77,  64,  76 ]
    geom.face(119).n_poi = 3; allocate(geom.face(119).poi(3)); geom.face(119).poi(1:3) = [ 66,  65,  78 ]
    geom.face(120).n_poi = 3; allocate(geom.face(120).poi(3)); geom.face(120).poi(1:3) = [ 78,  65,  77 ]
    geom.face(121).n_poi = 3; allocate(geom.face(121).poi(3)); geom.face(121).poi(1:3) = [ 67,  66,  79 ]
    geom.face(122).n_poi = 3; allocate(geom.face(122).poi(3)); geom.face(122).poi(1:3) = [ 79,  66,  78 ]
    geom.face(123).n_poi = 3; allocate(geom.face(123).poi(3)); geom.face(123).poi(1:3) = [ 68,  67,  80 ]
    geom.face(124).n_poi = 3; allocate(geom.face(124).poi(3)); geom.face(124).poi(1:3) = [ 80,  67,  79 ]
    geom.face(125).n_poi = 3; allocate(geom.face(125).poi(3)); geom.face(125).poi(1:3) = [ 69,  68,  81 ]
    geom.face(126).n_poi = 3; allocate(geom.face(126).poi(3)); geom.face(126).poi(1:3) = [ 81,  68,  80 ]
    geom.face(127).n_poi = 3; allocate(geom.face(127).poi(3)); geom.face(127).poi(1:3) = [ 70,  69,  82 ]
    geom.face(128).n_poi = 3; allocate(geom.face(128).poi(3)); geom.face(128).poi(1:3) = [ 82,  69,  81 ]
    geom.face(129).n_poi = 3; allocate(geom.face(129).poi(3)); geom.face(129).poi(1:3) = [ 71,  72,  83 ]
    geom.face(130).n_poi = 3; allocate(geom.face(130).poi(3)); geom.face(130).poi(1:3) = [ 83,  72,  84 ]
    geom.face(131).n_poi = 3; allocate(geom.face(131).poi(3)); geom.face(131).poi(1:3) = [ 62,  71,  74 ]
    geom.face(132).n_poi = 3; allocate(geom.face(132).poi(3)); geom.face(132).poi(1:3) = [ 74,  71,  83 ]
    geom.face(133).n_poi = 3; allocate(geom.face(133).poi(3)); geom.face(133).poi(1:3) = [ 73,  74,  85 ]
    geom.face(134).n_poi = 3; allocate(geom.face(134).poi(3)); geom.face(134).poi(1:3) = [ 85,  74,  86 ]
    geom.face(135).n_poi = 3; allocate(geom.face(135).poi(3)); geom.face(135).poi(1:3) = [ 75,  73,  87 ]
    geom.face(136).n_poi = 3; allocate(geom.face(136).poi(3)); geom.face(136).poi(1:3) = [ 87,  73,  85 ]
    geom.face(137).n_poi = 3; allocate(geom.face(137).poi(3)); geom.face(137).poi(1:3) = [ 76,  75,  88 ]
    geom.face(138).n_poi = 3; allocate(geom.face(138).poi(3)); geom.face(138).poi(1:3) = [ 88,  75,  87 ]
    geom.face(139).n_poi = 3; allocate(geom.face(139).poi(3)); geom.face(139).poi(1:3) = [ 77,  76,  89 ]
    geom.face(140).n_poi = 3; allocate(geom.face(140).poi(3)); geom.face(140).poi(1:3) = [ 89,  76,  88 ]
    geom.face(141).n_poi = 3; allocate(geom.face(141).poi(3)); geom.face(141).poi(1:3) = [ 78,  77,  90 ]
    geom.face(142).n_poi = 3; allocate(geom.face(142).poi(3)); geom.face(142).poi(1:3) = [ 90,  77,  89 ]
    geom.face(143).n_poi = 3; allocate(geom.face(143).poi(3)); geom.face(143).poi(1:3) = [ 79,  78,  91 ]
    geom.face(144).n_poi = 3; allocate(geom.face(144).poi(3)); geom.face(144).poi(1:3) = [ 91,  78,  90 ]
    geom.face(145).n_poi = 3; allocate(geom.face(145).poi(3)); geom.face(145).poi(1:3) = [ 80,  79,  92 ]
    geom.face(146).n_poi = 3; allocate(geom.face(146).poi(3)); geom.face(146).poi(1:3) = [ 92,  79,  91 ]
    geom.face(147).n_poi = 3; allocate(geom.face(147).poi(3)); geom.face(147).poi(1:3) = [ 81,  80,  93 ]
    geom.face(148).n_poi = 3; allocate(geom.face(148).poi(3)); geom.face(148).poi(1:3) = [ 93,  80,  92 ]
    geom.face(149).n_poi = 3; allocate(geom.face(149).poi(3)); geom.face(149).poi(1:3) = [ 82,  81,  94 ]
    geom.face(150).n_poi = 3; allocate(geom.face(150).poi(3)); geom.face(150).poi(1:3) = [ 94,  81,  93 ]
    geom.face(151).n_poi = 3; allocate(geom.face(151).poi(3)); geom.face(151).poi(1:3) = [ 83,  84,  95 ]
    geom.face(152).n_poi = 3; allocate(geom.face(152).poi(3)); geom.face(152).poi(1:3) = [ 95,  84,  96 ]
    geom.face(153).n_poi = 3; allocate(geom.face(153).poi(3)); geom.face(153).poi(1:3) = [ 74,  83,  86 ]
    geom.face(154).n_poi = 3; allocate(geom.face(154).poi(3)); geom.face(154).poi(1:3) = [ 86,  83,  95 ]
    geom.face(155).n_poi = 3; allocate(geom.face(155).poi(3)); geom.face(155).poi(1:3) = [ 85,  86,   1 ]
    geom.face(156).n_poi = 3; allocate(geom.face(156).poi(3)); geom.face(156).poi(1:3) = [  1,  86,   2 ]
    geom.face(157).n_poi = 3; allocate(geom.face(157).poi(3)); geom.face(157).poi(1:3) = [ 87,  85,   5 ]
    geom.face(158).n_poi = 3; allocate(geom.face(158).poi(3)); geom.face(158).poi(1:3) = [  5,  85,   1 ]
    geom.face(159).n_poi = 3; allocate(geom.face(159).poi(3)); geom.face(159).poi(1:3) = [ 88,  87,   7 ]
    geom.face(160).n_poi = 3; allocate(geom.face(160).poi(3)); geom.face(160).poi(1:3) = [  7,  87,   5 ]
    geom.face(161).n_poi = 3; allocate(geom.face(161).poi(3)); geom.face(161).poi(1:3) = [ 89,  88,   9 ]
    geom.face(162).n_poi = 3; allocate(geom.face(162).poi(3)); geom.face(162).poi(1:3) = [  9,  88,   7 ]
    geom.face(163).n_poi = 3; allocate(geom.face(163).poi(3)); geom.face(163).poi(1:3) = [ 90,  89,  11 ]
    geom.face(164).n_poi = 3; allocate(geom.face(164).poi(3)); geom.face(164).poi(1:3) = [ 11,  89,   9 ]
    geom.face(165).n_poi = 3; allocate(geom.face(165).poi(3)); geom.face(165).poi(1:3) = [ 91,  90,  13 ]
    geom.face(166).n_poi = 3; allocate(geom.face(166).poi(3)); geom.face(166).poi(1:3) = [ 13,  90,  11 ]
    geom.face(167).n_poi = 3; allocate(geom.face(167).poi(3)); geom.face(167).poi(1:3) = [ 92,  91,  15 ]
    geom.face(168).n_poi = 3; allocate(geom.face(168).poi(3)); geom.face(168).poi(1:3) = [ 15,  91,  13 ]
    geom.face(169).n_poi = 3; allocate(geom.face(169).poi(3)); geom.face(169).poi(1:3) = [ 93,  92,  17 ]
    geom.face(170).n_poi = 3; allocate(geom.face(170).poi(3)); geom.face(170).poi(1:3) = [ 17,  92,  15 ]
    geom.face(171).n_poi = 3; allocate(geom.face(171).poi(3)); geom.face(171).poi(1:3) = [ 94,  93,  19 ]
    geom.face(172).n_poi = 3; allocate(geom.face(172).poi(3)); geom.face(172).poi(1:3) = [ 19,  93,  17 ]
    geom.face(173).n_poi = 3; allocate(geom.face(173).poi(3)); geom.face(173).poi(1:3) = [ 95,  96,  21 ]
    geom.face(174).n_poi = 3; allocate(geom.face(174).poi(3)); geom.face(174).poi(1:3) = [ 21,  96,  22 ]
    geom.face(175).n_poi = 3; allocate(geom.face(175).poi(3)); geom.face(175).poi(1:3) = [ 86,  95,   2 ]
    geom.face(176).n_poi = 3; allocate(geom.face(176).poi(3)); geom.face(176).poi(1:3) = [  2,  95,  21 ]
    geom.face(177).n_poi = 3; allocate(geom.face(177).poi(3)); geom.face(177).poi(1:3) = [ 94,  97,  82 ]
    geom.face(178).n_poi = 3; allocate(geom.face(178).poi(3)); geom.face(178).poi(1:3) = [ 72,  98,  84 ]
    geom.face(179).n_poi = 3; allocate(geom.face(179).poi(3)); geom.face(179).poi(1:3) = [ 46,  97,  34 ]
    geom.face(180).n_poi = 3; allocate(geom.face(180).poi(3)); geom.face(180).poi(1:3) = [ 20,  34,  97 ]
    geom.face(181).n_poi = 3; allocate(geom.face(181).poi(3)); geom.face(181).poi(1:3) = [ 58,  97,  46 ]
    geom.face(182).n_poi = 3; allocate(geom.face(182).poi(3)); geom.face(182).poi(1:3) = [ 70,  97,  58 ]
    geom.face(183).n_poi = 3; allocate(geom.face(183).poi(3)); geom.face(183).poi(1:3) = [ 82,  97,  70 ]
    geom.face(184).n_poi = 3; allocate(geom.face(184).poi(3)); geom.face(184).poi(1:3) = [ 19,  97,  94 ]
    geom.face(185).n_poi = 3; allocate(geom.face(185).poi(3)); geom.face(185).poi(1:3) = [ 20,  97,  19 ]
    geom.face(186).n_poi = 3; allocate(geom.face(186).poi(3)); geom.face(186).poi(1:3) = [ 24,  98,  36 ]
    geom.face(187).n_poi = 3; allocate(geom.face(187).poi(3)); geom.face(187).poi(1:3) = [ 36,  98,  48 ]
    geom.face(188).n_poi = 3; allocate(geom.face(188).poi(3)); geom.face(188).poi(1:3) = [ 48,  98,  60 ]
    geom.face(189).n_poi = 3; allocate(geom.face(189).poi(3)); geom.face(189).poi(1:3) = [ 60,  98,  72 ]
    geom.face(190).n_poi = 3; allocate(geom.face(190).poi(3)); geom.face(190).poi(1:3) = [ 98,  96,  84 ]
    geom.face(191).n_poi = 3; allocate(geom.face(191).poi(3)); geom.face(191).poi(1:3) = [ 98,  22,  96 ]
    geom.face(192).n_poi = 3; allocate(geom.face(192).poi(3)); geom.face(192).poi(1:3) = [ 24,  22,  98 ]
end subroutine Exam_Asym_Nickedtorus

! -----------------------------------------------------------------------------

! Example of Helix
subroutine Exam_Asym_Helix(prob, geom)
    type(ProbType), intent(inout) :: prob
    type(GeomType), intent(inout) :: geom

    character(10) :: char_sec, char_bp, char_start_bp

    write(unit=char_sec,      fmt = "(i10)"), prob.sel_sec
    write(unit=char_bp,       fmt = "(i10)"), prob.n_bp_edge
    write(unit=char_start_bp, fmt = "(i10)"), para_start_bp_ID

    prob.name_prob = "Helix"
    prob.name_file = "Helix"//&
        "_"//trim(adjustl(trim(char_sec)))//"cs"//&
        "_"//trim(adjustl(trim(char_bp)))//"bp"//&
        "_"//trim(para_vertex_design)

    ! Problem specified preset parameters
    if(para_vertex_design == "flat" .and. para_preset == "on") then
        para_junc_ang        = "max"    ! Junction gap modification for different arm angle
        para_const_edge_mesh = "off"    ! Constant edge length from polyhedra mesh
        para_unpaired_scaf   = "off"    ! Unpaired scaffold nucleotides
        para_n_base_tn       = 7
    end if

    ! Set geometric type and view (atom, cylinder size, move_x, move_y)
    call Mani_Set_View_Color(prob, [195, 153, 107], "xy")

    ! Allocate point and face structure
    geom.n_iniP = 105
    geom.n_face = 206

    allocate(geom.iniP(geom.n_iniP))
    allocate(geom.face(geom.n_face))

    ! Set point position vectors
    geom.iniP(  1).pos(1:3) = [  31.19078d0, -47.93337d0,   5.56163d0 ]; geom.iniP(  2).pos(1:3) = [  19.79087d0, -44.22930d0,   5.56163d0 ]
    geom.iniP(  3).pos(1:3) = [  27.79107d0, -44.10975d0,  -8.59865d0 ]; geom.iniP(  4).pos(1:3) = [  17.63379d0, -40.40569d0,  -3.42323d0 ]
    geom.iniP(  5).pos(1:3) = [  19.79087d0, -32.24303d0,   5.56163d0 ]; geom.iniP(  6).pos(1:3) = [  17.63379d0, -28.41941d0,  -3.42323d0 ]
    geom.iniP(  7).pos(1:3) = [  31.19078d0, -28.53896d0,   5.56163d0 ]; geom.iniP(  8).pos(1:3) = [  27.79107d0, -24.71527d0,  -8.59865d0 ]
    geom.iniP(  9).pos(1:3) = [  38.23618d0, -38.23617d0,   5.56163d0 ]; geom.iniP( 10).pos(1:3) = [  34.06869d0, -34.41255d0, -11.79723d0 ]
    geom.iniP( 11).pos(1:3) = [  18.33343d0, -40.28614d0, -19.67217d0 ]; geom.iniP( 12).pos(1:3) = [  11.63278d0, -36.58207d0, -10.44951d0 ]
    geom.iniP( 13).pos(1:3) = [  11.63278d0, -24.59569d0, -10.44951d0 ]; geom.iniP( 14).pos(1:3) = [  18.33343d0, -20.89165d0, -19.67217d0 ]
    geom.iniP( 15).pos(1:3) = [  22.47467d0, -30.58893d0, -25.37219d0 ]; geom.iniP( 16).pos(1:3) = [   4.87930d0, -36.46252d0, -25.24499d0 ]
    geom.iniP( 17).pos(1:3) = [   3.09599d0, -32.75845d0, -13.98559d0 ]; geom.iniP( 18).pos(1:3) = [   3.09599d0, -20.77208d0, -13.98559d0 ]
    geom.iniP( 19).pos(1:3) = [   4.87930d0, -17.06806d0, -25.24499d0 ]; geom.iniP( 20).pos(1:3) = [   5.98147d0, -26.76532d0, -32.20372d0 ]
    geom.iniP( 21).pos(1:3) = [  -9.63844d0, -32.63890d0, -24.10250d0 ]; geom.iniP( 22).pos(1:3) = [  -6.11572d0, -28.93484d0, -13.26060d0 ]
    geom.iniP( 23).pos(1:3) = [  -6.11572d0, -16.94846d0, -13.26060d0 ]; geom.iniP( 24).pos(1:3) = [  -9.63844d0, -13.24445d0, -24.10250d0 ]
    geom.iniP( 25).pos(1:3) = [ -11.81563d0, -22.94170d0, -30.80300d0 ]; geom.iniP( 26).pos(1:3) = [ -22.05515d0, -28.81528d0, -16.49352d0 ]
    geom.iniP( 27).pos(1:3) = [ -13.99425d0, -25.11132d0,  -8.43263d0 ]; geom.iniP( 28).pos(1:3) = [ -13.99425d0, -13.12484d0,  -8.43263d0 ]
    geom.iniP( 29).pos(1:3) = [ -22.05515d0,  -9.42083d0, -16.49352d0 ]; geom.iniP( 30).pos(1:3) = [ -27.03704d0, -19.11808d0, -21.47542d0 ]
    geom.iniP( 31).pos(1:3) = [ -29.66412d0, -24.99174d0,  -4.07681d0 ]; geom.iniP( 32).pos(1:3) = [ -18.82223d0, -21.28770d0,  -0.55409d0 ]
    geom.iniP( 33).pos(1:3) = [ -18.82223d0,  -9.30123d0,  -0.55409d0 ]; geom.iniP( 34).pos(1:3) = [ -29.66412d0,  -5.59721d0,  -4.07681d0 ]
    geom.iniP( 35).pos(1:3) = [ -36.36463d0, -15.29447d0,  -6.25400d0 ]; geom.iniP( 36).pos(1:3) = [ -30.80662d0, -21.16813d0,  10.44093d0 ]
    geom.iniP( 37).pos(1:3) = [ -19.54722d0, -17.46409d0,   8.65762d0 ]; geom.iniP( 38).pos(1:3) = [ -19.54722d0,  -5.47761d0,   8.65762d0 ]
    geom.iniP( 39).pos(1:3) = [ -30.80662d0,  -1.77358d0,  10.44093d0 ]; geom.iniP( 40).pos(1:3) = [ -37.76535d0, -11.47085d0,  11.54310d0 ]
    geom.iniP( 41).pos(1:3) = [ -25.23380d0, -17.34451d0,  23.89506d0 ]; geom.iniP( 42).pos(1:3) = [ -16.01113d0, -13.64047d0,  17.19440d0 ]
    geom.iniP( 43).pos(1:3) = [ -16.01113d0,  -1.65399d0,  17.19440d0 ]; geom.iniP( 44).pos(1:3) = [ -25.23380d0,   2.05003d0,  23.89506d0 ]
    geom.iniP( 45).pos(1:3) = [ -30.93382d0,  -7.64723d0,  28.03629d0 ]; geom.iniP( 46).pos(1:3) = [ -14.16027d0, -13.52089d0,  33.35270d0 ]
    geom.iniP( 47).pos(1:3) = [  -8.98486d0,  -9.81685d0,  23.19542d0 ]; geom.iniP( 48).pos(1:3) = [  -8.98486d0,   2.16962d0,  23.19542d0 ]
    geom.iniP( 49).pos(1:3) = [ -14.16027d0,   5.87364d0,  33.35270d0 ]; geom.iniP( 50).pos(1:3) = [ -17.35886d0,  -3.82361d0,  39.63032d0 ]
    geom.iniP( 51).pos(1:3) = [   0.00001d0,  -9.69728d0,  36.75241d0 ]; geom.iniP( 52).pos(1:3) = [   0.00001d0,  -5.99324d0,  25.35250d0 ]
    geom.iniP( 53).pos(1:3) = [   0.00001d0,   5.99324d0,  25.35250d0 ]; geom.iniP( 54).pos(1:3) = [   0.00001d0,   9.69726d0,  36.75241d0 ]
    geom.iniP( 55).pos(1:3) = [   0.00001d0,   0.00000d0,  43.79780d0 ]; geom.iniP( 56).pos(1:3) = [  14.16029d0,  -5.87366d0,  33.35270d0 ]
    geom.iniP( 57).pos(1:3) = [   8.98487d0,  -2.16963d0,  23.19542d0 ]; geom.iniP( 58).pos(1:3) = [   8.98487d0,   9.81686d0,  23.19542d0 ]
    geom.iniP( 59).pos(1:3) = [  14.16029d0,  13.52087d0,  33.35270d0 ]; geom.iniP( 60).pos(1:3) = [  17.35887d0,   3.82362d0,  39.63032d0 ]
    geom.iniP( 61).pos(1:3) = [  25.23381d0,  -2.05004d0,  23.89506d0 ]; geom.iniP( 62).pos(1:3) = [  16.01115d0,   1.65399d0,  17.19440d0 ]
    geom.iniP( 63).pos(1:3) = [  16.01115d0,  13.64048d0,  17.19440d0 ]; geom.iniP( 64).pos(1:3) = [  25.23381d0,  17.34449d0,  23.89506d0 ]
    geom.iniP( 65).pos(1:3) = [  30.93383d0,   7.64724d0,  28.03627d0 ]; geom.iniP( 66).pos(1:3) = [  30.80663d0,   1.77358d0,  10.44093d0 ]
    geom.iniP( 67).pos(1:3) = [  19.54723d0,   5.47761d0,   8.65759d0 ]; geom.iniP( 68).pos(1:3) = [  19.54723d0,  17.46409d0,   8.65759d0 ]
    geom.iniP( 69).pos(1:3) = [  30.80663d0,  21.16811d0,  10.44093d0 ]; geom.iniP( 70).pos(1:3) = [  37.76536d0,  11.47085d0,  11.54307d0 ]
    geom.iniP( 71).pos(1:3) = [  29.66414d0,   5.59719d0,  -4.07684d0 ]; geom.iniP( 72).pos(1:3) = [  18.82225d0,   9.30123d0,  -0.55409d0 ]
    geom.iniP( 73).pos(1:3) = [  18.82225d0,  21.28771d0,  -0.55409d0 ]; geom.iniP( 74).pos(1:3) = [  29.66414d0,  24.99172d0,  -4.07684d0 ]
    geom.iniP( 75).pos(1:3) = [  36.36464d0,  15.29447d0,  -6.25403d0 ]; geom.iniP( 76).pos(1:3) = [  22.05514d0,   9.42081d0, -16.49355d0 ]
    geom.iniP( 77).pos(1:3) = [  13.99424d0,  13.12485d0,  -8.43263d0 ]; geom.iniP( 78).pos(1:3) = [  13.99424d0,  25.11133d0,  -8.43263d0 ]
    geom.iniP( 79).pos(1:3) = [  22.05514d0,  28.81529d0, -16.49355d0 ]; geom.iniP( 80).pos(1:3) = [  27.03706d0,  19.11809d0, -21.47542d0 ]
    geom.iniP( 81).pos(1:3) = [   9.63843d0,  13.24443d0, -24.10250d0 ]; geom.iniP( 82).pos(1:3) = [   6.11570d0,  16.94847d0, -13.26060d0 ]
    geom.iniP( 83).pos(1:3) = [   6.11570d0,  28.93484d0, -13.26060d0 ]; geom.iniP( 84).pos(1:3) = [   9.63843d0,  32.63891d0, -24.10250d0 ]
    geom.iniP( 85).pos(1:3) = [  11.81560d0,  22.94170d0, -30.80326d0 ]; geom.iniP( 86).pos(1:3) = [  -4.87934d0,  17.06804d0, -25.24499d0 ]
    geom.iniP( 87).pos(1:3) = [  -3.09600d0,  20.77208d0, -13.98556d0 ]; geom.iniP( 88).pos(1:3) = [  -3.09600d0,  32.75846d0, -13.98556d0 ]
    geom.iniP( 89).pos(1:3) = [  -4.87934d0,  36.46252d0, -25.24499d0 ]; geom.iniP( 90).pos(1:3) = [  -5.98151d0,  26.76532d0, -32.20372d0 ]
    geom.iniP( 91).pos(1:3) = [ -18.33347d0,  20.89166d0, -19.67215d0 ]; geom.iniP( 92).pos(1:3) = [ -11.63279d0,  24.59570d0, -10.44951d0 ]
    geom.iniP( 93).pos(1:3) = [ -11.63279d0,  36.58208d0, -10.44951d0 ]; geom.iniP( 94).pos(1:3) = [ -18.33347d0,  40.28614d0, -19.67215d0 ]
    geom.iniP( 95).pos(1:3) = [ -22.47470d0,  30.58894d0, -25.37194d0 ]; geom.iniP( 96).pos(1:3) = [ -27.79106d0,  24.71528d0,  -8.59860d0 ]
    geom.iniP( 97).pos(1:3) = [ -17.63380d0,  28.41942d0,  -3.42320d0 ]; geom.iniP( 98).pos(1:3) = [ -17.63380d0,  40.40569d0,  -3.42320d0 ]
    geom.iniP( 99).pos(1:3) = [ -27.79106d0,  44.10976d0,  -8.59860d0 ]; geom.iniP(100).pos(1:3) = [ -34.06868d0,  34.41256d0, -11.79715d0 ]
    geom.iniP(101).pos(1:3) = [ -31.19077d0,  28.53897d0,   5.56169d0 ]; geom.iniP(102).pos(1:3) = [ -19.79086d0,  32.24304d0,   5.56167d0 ]
    geom.iniP(103).pos(1:3) = [ -19.79086d0,  44.22931d0,   5.56167d0 ]; geom.iniP(104).pos(1:3) = [ -31.19077d0,  47.93337d0,   5.56170d0 ]
    geom.iniP(105).pos(1:3) = [ -38.23616d0,  38.23617d0,   5.56171d0 ]

    ! Set face connnectivity
    geom.face(  1).n_poi = 3; allocate(geom.face(  1).poi(3)); geom.face(  1).poi(1:3) = [   1,  2,  3 ]
    geom.face(  2).n_poi = 3; allocate(geom.face(  2).poi(3)); geom.face(  2).poi(1:3) = [   3,  2,  4 ]
    geom.face(  3).n_poi = 3; allocate(geom.face(  3).poi(3)); geom.face(  3).poi(1:3) = [   2,  5,  4 ]
    geom.face(  4).n_poi = 3; allocate(geom.face(  4).poi(3)); geom.face(  4).poi(1:3) = [   4,  5,  6 ]
    geom.face(  5).n_poi = 3; allocate(geom.face(  5).poi(3)); geom.face(  5).poi(1:3) = [   5,  7,  6 ]
    geom.face(  6).n_poi = 3; allocate(geom.face(  6).poi(3)); geom.face(  6).poi(1:3) = [   6,  7,  8 ]
    geom.face(  7).n_poi = 3; allocate(geom.face(  7).poi(3)); geom.face(  7).poi(1:3) = [   9, 10,  7 ]
    geom.face(  8).n_poi = 3; allocate(geom.face(  8).poi(3)); geom.face(  8).poi(1:3) = [   7, 10,  8 ]
    geom.face(  9).n_poi = 3; allocate(geom.face(  9).poi(3)); geom.face(  9).poi(1:3) = [   1,  3,  9 ]
    geom.face( 10).n_poi = 3; allocate(geom.face( 10).poi(3)); geom.face( 10).poi(1:3) = [   9,  3, 10 ]
    geom.face( 11).n_poi = 3; allocate(geom.face( 11).poi(3)); geom.face( 11).poi(1:3) = [   3,  4, 11 ]
    geom.face( 12).n_poi = 3; allocate(geom.face( 12).poi(3)); geom.face( 12).poi(1:3) = [  11,  4, 12 ]
    geom.face( 13).n_poi = 3; allocate(geom.face( 13).poi(3)); geom.face( 13).poi(1:3) = [   4,  6, 12 ]
    geom.face( 14).n_poi = 3; allocate(geom.face( 14).poi(3)); geom.face( 14).poi(1:3) = [  12,  6, 13 ]
    geom.face( 15).n_poi = 3; allocate(geom.face( 15).poi(3)); geom.face( 15).poi(1:3) = [   6,  8, 13 ]
    geom.face( 16).n_poi = 3; allocate(geom.face( 16).poi(3)); geom.face( 16).poi(1:3) = [  13,  8, 14 ]
    geom.face( 17).n_poi = 3; allocate(geom.face( 17).poi(3)); geom.face( 17).poi(1:3) = [  10, 15,  8 ]
    geom.face( 18).n_poi = 3; allocate(geom.face( 18).poi(3)); geom.face( 18).poi(1:3) = [   8, 15, 14 ]
    geom.face( 19).n_poi = 3; allocate(geom.face( 19).poi(3)); geom.face( 19).poi(1:3) = [   3, 11, 10 ]
    geom.face( 20).n_poi = 3; allocate(geom.face( 20).poi(3)); geom.face( 20).poi(1:3) = [  10, 11, 15 ]
    geom.face( 21).n_poi = 3; allocate(geom.face( 21).poi(3)); geom.face( 21).poi(1:3) = [  11, 12, 16 ]
    geom.face( 22).n_poi = 3; allocate(geom.face( 22).poi(3)); geom.face( 22).poi(1:3) = [  16, 12, 17 ]
    geom.face( 23).n_poi = 3; allocate(geom.face( 23).poi(3)); geom.face( 23).poi(1:3) = [  12, 13, 17 ]
    geom.face( 24).n_poi = 3; allocate(geom.face( 24).poi(3)); geom.face( 24).poi(1:3) = [  17, 13, 18 ]
    geom.face( 25).n_poi = 3; allocate(geom.face( 25).poi(3)); geom.face( 25).poi(1:3) = [  13, 14, 18 ]
    geom.face( 26).n_poi = 3; allocate(geom.face( 26).poi(3)); geom.face( 26).poi(1:3) = [  18, 14, 19 ]
    geom.face( 27).n_poi = 3; allocate(geom.face( 27).poi(3)); geom.face( 27).poi(1:3) = [  15, 20, 14 ]
    geom.face( 28).n_poi = 3; allocate(geom.face( 28).poi(3)); geom.face( 28).poi(1:3) = [  14, 20, 19 ]
    geom.face( 29).n_poi = 3; allocate(geom.face( 29).poi(3)); geom.face( 29).poi(1:3) = [  11, 16, 15 ]
    geom.face( 30).n_poi = 3; allocate(geom.face( 30).poi(3)); geom.face( 30).poi(1:3) = [  15, 16, 20 ]
    geom.face( 31).n_poi = 3; allocate(geom.face( 31).poi(3)); geom.face( 31).poi(1:3) = [  16, 17, 21 ]
    geom.face( 32).n_poi = 3; allocate(geom.face( 32).poi(3)); geom.face( 32).poi(1:3) = [  21, 17, 22 ]
    geom.face( 33).n_poi = 3; allocate(geom.face( 33).poi(3)); geom.face( 33).poi(1:3) = [  17, 18, 22 ]
    geom.face( 34).n_poi = 3; allocate(geom.face( 34).poi(3)); geom.face( 34).poi(1:3) = [  22, 18, 23 ]
    geom.face( 35).n_poi = 3; allocate(geom.face( 35).poi(3)); geom.face( 35).poi(1:3) = [  18, 19, 23 ]
    geom.face( 36).n_poi = 3; allocate(geom.face( 36).poi(3)); geom.face( 36).poi(1:3) = [  23, 19, 24 ]
    geom.face( 37).n_poi = 3; allocate(geom.face( 37).poi(3)); geom.face( 37).poi(1:3) = [  20, 25, 19 ]
    geom.face( 38).n_poi = 3; allocate(geom.face( 38).poi(3)); geom.face( 38).poi(1:3) = [  19, 25, 24 ]
    geom.face( 39).n_poi = 3; allocate(geom.face( 39).poi(3)); geom.face( 39).poi(1:3) = [  16, 21, 20 ]
    geom.face( 40).n_poi = 3; allocate(geom.face( 40).poi(3)); geom.face( 40).poi(1:3) = [  20, 21, 25 ]
    geom.face( 41).n_poi = 3; allocate(geom.face( 41).poi(3)); geom.face( 41).poi(1:3) = [  21, 22, 26 ]
    geom.face( 42).n_poi = 3; allocate(geom.face( 42).poi(3)); geom.face( 42).poi(1:3) = [  26, 22, 27 ]
    geom.face( 43).n_poi = 3; allocate(geom.face( 43).poi(3)); geom.face( 43).poi(1:3) = [  22, 23, 27 ]
    geom.face( 44).n_poi = 3; allocate(geom.face( 44).poi(3)); geom.face( 44).poi(1:3) = [  27, 23, 28 ]
    geom.face( 45).n_poi = 3; allocate(geom.face( 45).poi(3)); geom.face( 45).poi(1:3) = [  23, 24, 28 ]
    geom.face( 46).n_poi = 3; allocate(geom.face( 46).poi(3)); geom.face( 46).poi(1:3) = [  28, 24, 29 ]
    geom.face( 47).n_poi = 3; allocate(geom.face( 47).poi(3)); geom.face( 47).poi(1:3) = [  25, 30, 24 ]
    geom.face( 48).n_poi = 3; allocate(geom.face( 48).poi(3)); geom.face( 48).poi(1:3) = [  24, 30, 29 ]
    geom.face( 49).n_poi = 3; allocate(geom.face( 49).poi(3)); geom.face( 49).poi(1:3) = [  21, 26, 25 ]
    geom.face( 50).n_poi = 3; allocate(geom.face( 50).poi(3)); geom.face( 50).poi(1:3) = [  25, 26, 30 ]
    geom.face( 51).n_poi = 3; allocate(geom.face( 51).poi(3)); geom.face( 51).poi(1:3) = [  26, 27, 31 ]
    geom.face( 52).n_poi = 3; allocate(geom.face( 52).poi(3)); geom.face( 52).poi(1:3) = [  31, 27, 32 ]
    geom.face( 53).n_poi = 3; allocate(geom.face( 53).poi(3)); geom.face( 53).poi(1:3) = [  27, 28, 32 ]
    geom.face( 54).n_poi = 3; allocate(geom.face( 54).poi(3)); geom.face( 54).poi(1:3) = [  32, 28, 33 ]
    geom.face( 55).n_poi = 3; allocate(geom.face( 55).poi(3)); geom.face( 55).poi(1:3) = [  28, 29, 33 ]
    geom.face( 56).n_poi = 3; allocate(geom.face( 56).poi(3)); geom.face( 56).poi(1:3) = [  33, 29, 34 ]
    geom.face( 57).n_poi = 3; allocate(geom.face( 57).poi(3)); geom.face( 57).poi(1:3) = [  30, 35, 29 ]
    geom.face( 58).n_poi = 3; allocate(geom.face( 58).poi(3)); geom.face( 58).poi(1:3) = [  29, 35, 34 ]
    geom.face( 59).n_poi = 3; allocate(geom.face( 59).poi(3)); geom.face( 59).poi(1:3) = [  26, 31, 30 ]
    geom.face( 60).n_poi = 3; allocate(geom.face( 60).poi(3)); geom.face( 60).poi(1:3) = [  30, 31, 35 ]
    geom.face( 61).n_poi = 3; allocate(geom.face( 61).poi(3)); geom.face( 61).poi(1:3) = [  31, 32, 36 ]
    geom.face( 62).n_poi = 3; allocate(geom.face( 62).poi(3)); geom.face( 62).poi(1:3) = [  36, 32, 37 ]
    geom.face( 63).n_poi = 3; allocate(geom.face( 63).poi(3)); geom.face( 63).poi(1:3) = [  32, 33, 37 ]
    geom.face( 64).n_poi = 3; allocate(geom.face( 64).poi(3)); geom.face( 64).poi(1:3) = [  37, 33, 38 ]
    geom.face( 65).n_poi = 3; allocate(geom.face( 65).poi(3)); geom.face( 65).poi(1:3) = [  33, 34, 38 ]
    geom.face( 66).n_poi = 3; allocate(geom.face( 66).poi(3)); geom.face( 66).poi(1:3) = [  38, 34, 39 ]
    geom.face( 67).n_poi = 3; allocate(geom.face( 67).poi(3)); geom.face( 67).poi(1:3) = [  35, 40, 34 ]
    geom.face( 68).n_poi = 3; allocate(geom.face( 68).poi(3)); geom.face( 68).poi(1:3) = [  34, 40, 39 ]
    geom.face( 69).n_poi = 3; allocate(geom.face( 69).poi(3)); geom.face( 69).poi(1:3) = [  31, 36, 35 ]
    geom.face( 70).n_poi = 3; allocate(geom.face( 70).poi(3)); geom.face( 70).poi(1:3) = [  35, 36, 40 ]
    geom.face( 71).n_poi = 3; allocate(geom.face( 71).poi(3)); geom.face( 71).poi(1:3) = [  36, 37, 41 ]
    geom.face( 72).n_poi = 3; allocate(geom.face( 72).poi(3)); geom.face( 72).poi(1:3) = [  41, 37, 42 ]
    geom.face( 73).n_poi = 3; allocate(geom.face( 73).poi(3)); geom.face( 73).poi(1:3) = [  37, 38, 42 ]
    geom.face( 74).n_poi = 3; allocate(geom.face( 74).poi(3)); geom.face( 74).poi(1:3) = [  42, 38, 43 ]
    geom.face( 75).n_poi = 3; allocate(geom.face( 75).poi(3)); geom.face( 75).poi(1:3) = [  38, 39, 43 ]
    geom.face( 76).n_poi = 3; allocate(geom.face( 76).poi(3)); geom.face( 76).poi(1:3) = [  43, 39, 44 ]
    geom.face( 77).n_poi = 3; allocate(geom.face( 77).poi(3)); geom.face( 77).poi(1:3) = [  40, 45, 39 ]
    geom.face( 78).n_poi = 3; allocate(geom.face( 78).poi(3)); geom.face( 78).poi(1:3) = [  39, 45, 44 ]
    geom.face( 79).n_poi = 3; allocate(geom.face( 79).poi(3)); geom.face( 79).poi(1:3) = [  36, 41, 40 ]
    geom.face( 80).n_poi = 3; allocate(geom.face( 80).poi(3)); geom.face( 80).poi(1:3) = [  40, 41, 45 ]
    geom.face( 81).n_poi = 3; allocate(geom.face( 81).poi(3)); geom.face( 81).poi(1:3) = [  41, 42, 46 ]
    geom.face( 82).n_poi = 3; allocate(geom.face( 82).poi(3)); geom.face( 82).poi(1:3) = [  46, 42, 47 ]
    geom.face( 83).n_poi = 3; allocate(geom.face( 83).poi(3)); geom.face( 83).poi(1:3) = [  42, 43, 47 ]
    geom.face( 84).n_poi = 3; allocate(geom.face( 84).poi(3)); geom.face( 84).poi(1:3) = [  47, 43, 48 ]
    geom.face( 85).n_poi = 3; allocate(geom.face( 85).poi(3)); geom.face( 85).poi(1:3) = [  43, 44, 48 ]
    geom.face( 86).n_poi = 3; allocate(geom.face( 86).poi(3)); geom.face( 86).poi(1:3) = [  48, 44, 49 ]
    geom.face( 87).n_poi = 3; allocate(geom.face( 87).poi(3)); geom.face( 87).poi(1:3) = [  45, 50, 44 ]
    geom.face( 88).n_poi = 3; allocate(geom.face( 88).poi(3)); geom.face( 88).poi(1:3) = [  44, 50, 49 ]
    geom.face( 89).n_poi = 3; allocate(geom.face( 89).poi(3)); geom.face( 89).poi(1:3) = [  41, 46, 45 ]
    geom.face( 90).n_poi = 3; allocate(geom.face( 90).poi(3)); geom.face( 90).poi(1:3) = [  45, 46, 50 ]
    geom.face( 91).n_poi = 3; allocate(geom.face( 91).poi(3)); geom.face( 91).poi(1:3) = [  46, 47, 51 ]
    geom.face( 92).n_poi = 3; allocate(geom.face( 92).poi(3)); geom.face( 92).poi(1:3) = [  51, 47, 52 ]
    geom.face( 93).n_poi = 3; allocate(geom.face( 93).poi(3)); geom.face( 93).poi(1:3) = [  47, 48, 52 ]
    geom.face( 94).n_poi = 3; allocate(geom.face( 94).poi(3)); geom.face( 94).poi(1:3) = [  52, 48, 53 ]
    geom.face( 95).n_poi = 3; allocate(geom.face( 95).poi(3)); geom.face( 95).poi(1:3) = [  48, 49, 53 ]
    geom.face( 96).n_poi = 3; allocate(geom.face( 96).poi(3)); geom.face( 96).poi(1:3) = [  53, 49, 54 ]
    geom.face( 97).n_poi = 3; allocate(geom.face( 97).poi(3)); geom.face( 97).poi(1:3) = [  50, 55, 49 ]
    geom.face( 98).n_poi = 3; allocate(geom.face( 98).poi(3)); geom.face( 98).poi(1:3) = [  49, 55, 54 ]
    geom.face( 99).n_poi = 3; allocate(geom.face( 99).poi(3)); geom.face( 99).poi(1:3) = [  46, 51, 50 ]
    geom.face(100).n_poi = 3; allocate(geom.face(100).poi(3)); geom.face(100).poi(1:3) = [  50, 51, 55 ]
    geom.face(101).n_poi = 3; allocate(geom.face(101).poi(3)); geom.face(101).poi(1:3) = [  51, 52, 56 ]
    geom.face(102).n_poi = 3; allocate(geom.face(102).poi(3)); geom.face(102).poi(1:3) = [  56, 52, 57 ]
    geom.face(103).n_poi = 3; allocate(geom.face(103).poi(3)); geom.face(103).poi(1:3) = [  52, 53, 57 ]
    geom.face(104).n_poi = 3; allocate(geom.face(104).poi(3)); geom.face(104).poi(1:3) = [  57, 53, 58 ]
    geom.face(105).n_poi = 3; allocate(geom.face(105).poi(3)); geom.face(105).poi(1:3) = [  53, 54, 58 ]
    geom.face(106).n_poi = 3; allocate(geom.face(106).poi(3)); geom.face(106).poi(1:3) = [  58, 54, 59 ]
    geom.face(107).n_poi = 3; allocate(geom.face(107).poi(3)); geom.face(107).poi(1:3) = [  55, 60, 54 ]
    geom.face(108).n_poi = 3; allocate(geom.face(108).poi(3)); geom.face(108).poi(1:3) = [  54, 60, 59 ]
    geom.face(109).n_poi = 3; allocate(geom.face(109).poi(3)); geom.face(109).poi(1:3) = [  51, 56, 55 ]
    geom.face(110).n_poi = 3; allocate(geom.face(110).poi(3)); geom.face(110).poi(1:3) = [  55, 56, 60 ]
    geom.face(111).n_poi = 3; allocate(geom.face(111).poi(3)); geom.face(111).poi(1:3) = [  56, 57, 61 ]
    geom.face(112).n_poi = 3; allocate(geom.face(112).poi(3)); geom.face(112).poi(1:3) = [  61, 57, 62 ]
    geom.face(113).n_poi = 3; allocate(geom.face(113).poi(3)); geom.face(113).poi(1:3) = [  57, 58, 62 ]
    geom.face(114).n_poi = 3; allocate(geom.face(114).poi(3)); geom.face(114).poi(1:3) = [  62, 58, 63 ]
    geom.face(115).n_poi = 3; allocate(geom.face(115).poi(3)); geom.face(115).poi(1:3) = [  58, 59, 63 ]
    geom.face(116).n_poi = 3; allocate(geom.face(116).poi(3)); geom.face(116).poi(1:3) = [  63, 59, 64 ]
    geom.face(117).n_poi = 3; allocate(geom.face(117).poi(3)); geom.face(117).poi(1:3) = [  60, 65, 59 ]
    geom.face(118).n_poi = 3; allocate(geom.face(118).poi(3)); geom.face(118).poi(1:3) = [  59, 65, 64 ]
    geom.face(119).n_poi = 3; allocate(geom.face(119).poi(3)); geom.face(119).poi(1:3) = [  56, 61, 60 ]
    geom.face(120).n_poi = 3; allocate(geom.face(120).poi(3)); geom.face(120).poi(1:3) = [  60, 61, 65 ]
    geom.face(121).n_poi = 3; allocate(geom.face(121).poi(3)); geom.face(121).poi(1:3) = [  61, 62, 66 ]
    geom.face(122).n_poi = 3; allocate(geom.face(122).poi(3)); geom.face(122).poi(1:3) = [  66, 62, 67 ]
    geom.face(123).n_poi = 3; allocate(geom.face(123).poi(3)); geom.face(123).poi(1:3) = [  62, 63, 67 ]
    geom.face(124).n_poi = 3; allocate(geom.face(124).poi(3)); geom.face(124).poi(1:3) = [  67, 63, 68 ]
    geom.face(125).n_poi = 3; allocate(geom.face(125).poi(3)); geom.face(125).poi(1:3) = [  63, 64, 68 ]
    geom.face(126).n_poi = 3; allocate(geom.face(126).poi(3)); geom.face(126).poi(1:3) = [  68, 64, 69 ]
    geom.face(127).n_poi = 3; allocate(geom.face(127).poi(3)); geom.face(127).poi(1:3) = [  65, 70, 64 ]
    geom.face(128).n_poi = 3; allocate(geom.face(128).poi(3)); geom.face(128).poi(1:3) = [  64, 70, 69 ]
    geom.face(129).n_poi = 3; allocate(geom.face(129).poi(3)); geom.face(129).poi(1:3) = [  61, 66, 65 ]
    geom.face(130).n_poi = 3; allocate(geom.face(130).poi(3)); geom.face(130).poi(1:3) = [  65, 66, 70 ]
    geom.face(131).n_poi = 3; allocate(geom.face(131).poi(3)); geom.face(131).poi(1:3) = [  66, 67, 71 ]
    geom.face(132).n_poi = 3; allocate(geom.face(132).poi(3)); geom.face(132).poi(1:3) = [  71, 67, 72 ]
    geom.face(133).n_poi = 3; allocate(geom.face(133).poi(3)); geom.face(133).poi(1:3) = [  67, 68, 72 ]
    geom.face(134).n_poi = 3; allocate(geom.face(134).poi(3)); geom.face(134).poi(1:3) = [  72, 68, 73 ]
    geom.face(135).n_poi = 3; allocate(geom.face(135).poi(3)); geom.face(135).poi(1:3) = [  68, 69, 73 ]
    geom.face(136).n_poi = 3; allocate(geom.face(136).poi(3)); geom.face(136).poi(1:3) = [  73, 69, 74 ]
    geom.face(137).n_poi = 3; allocate(geom.face(137).poi(3)); geom.face(137).poi(1:3) = [  70, 75, 69 ]
    geom.face(138).n_poi = 3; allocate(geom.face(138).poi(3)); geom.face(138).poi(1:3) = [  69, 75, 74 ]
    geom.face(139).n_poi = 3; allocate(geom.face(139).poi(3)); geom.face(139).poi(1:3) = [  66, 71, 70 ]
    geom.face(140).n_poi = 3; allocate(geom.face(140).poi(3)); geom.face(140).poi(1:3) = [  70, 71, 75 ]
    geom.face(141).n_poi = 3; allocate(geom.face(141).poi(3)); geom.face(141).poi(1:3) = [  71, 72, 76 ]
    geom.face(142).n_poi = 3; allocate(geom.face(142).poi(3)); geom.face(142).poi(1:3) = [  76, 72, 77 ]
    geom.face(143).n_poi = 3; allocate(geom.face(143).poi(3)); geom.face(143).poi(1:3) = [  72, 73, 77 ]
    geom.face(144).n_poi = 3; allocate(geom.face(144).poi(3)); geom.face(144).poi(1:3) = [  77, 73, 78 ]
    geom.face(145).n_poi = 3; allocate(geom.face(145).poi(3)); geom.face(145).poi(1:3) = [  73, 74, 78 ]
    geom.face(146).n_poi = 3; allocate(geom.face(146).poi(3)); geom.face(146).poi(1:3) = [  78, 74, 79 ]
    geom.face(147).n_poi = 3; allocate(geom.face(147).poi(3)); geom.face(147).poi(1:3) = [  75, 80, 74 ]
    geom.face(148).n_poi = 3; allocate(geom.face(148).poi(3)); geom.face(148).poi(1:3) = [  74, 80, 79 ]
    geom.face(149).n_poi = 3; allocate(geom.face(149).poi(3)); geom.face(149).poi(1:3) = [  71, 76, 75 ]
    geom.face(150).n_poi = 3; allocate(geom.face(150).poi(3)); geom.face(150).poi(1:3) = [  75, 76, 80 ]
    geom.face(151).n_poi = 3; allocate(geom.face(151).poi(3)); geom.face(151).poi(1:3) = [  76, 77, 81 ]
    geom.face(152).n_poi = 3; allocate(geom.face(152).poi(3)); geom.face(152).poi(1:3) = [  81, 77, 82 ]
    geom.face(153).n_poi = 3; allocate(geom.face(153).poi(3)); geom.face(153).poi(1:3) = [  77, 78, 82 ]
    geom.face(154).n_poi = 3; allocate(geom.face(154).poi(3)); geom.face(154).poi(1:3) = [  82, 78, 83 ]
    geom.face(155).n_poi = 3; allocate(geom.face(155).poi(3)); geom.face(155).poi(1:3) = [  78, 79, 83 ]
    geom.face(156).n_poi = 3; allocate(geom.face(156).poi(3)); geom.face(156).poi(1:3) = [  83, 79, 84 ]
    geom.face(157).n_poi = 3; allocate(geom.face(157).poi(3)); geom.face(157).poi(1:3) = [  80, 85, 79 ]
    geom.face(158).n_poi = 3; allocate(geom.face(158).poi(3)); geom.face(158).poi(1:3) = [  79, 85, 84 ]
    geom.face(159).n_poi = 3; allocate(geom.face(159).poi(3)); geom.face(159).poi(1:3) = [  76, 81, 80 ]
    geom.face(160).n_poi = 3; allocate(geom.face(160).poi(3)); geom.face(160).poi(1:3) = [  80, 81, 85 ]
    geom.face(161).n_poi = 3; allocate(geom.face(161).poi(3)); geom.face(161).poi(1:3) = [  81, 82, 86 ]
    geom.face(162).n_poi = 3; allocate(geom.face(162).poi(3)); geom.face(162).poi(1:3) = [  86, 82, 87 ]
    geom.face(163).n_poi = 3; allocate(geom.face(163).poi(3)); geom.face(163).poi(1:3) = [  82, 83, 87 ]
    geom.face(164).n_poi = 3; allocate(geom.face(164).poi(3)); geom.face(164).poi(1:3) = [  87, 83, 88 ]
    geom.face(165).n_poi = 3; allocate(geom.face(165).poi(3)); geom.face(165).poi(1:3) = [  83, 84, 88 ]
    geom.face(166).n_poi = 3; allocate(geom.face(166).poi(3)); geom.face(166).poi(1:3) = [  88, 84, 89 ]
    geom.face(167).n_poi = 3; allocate(geom.face(167).poi(3)); geom.face(167).poi(1:3) = [  85, 90, 84 ]
    geom.face(168).n_poi = 3; allocate(geom.face(168).poi(3)); geom.face(168).poi(1:3) = [  84, 90, 89 ]
    geom.face(169).n_poi = 3; allocate(geom.face(169).poi(3)); geom.face(169).poi(1:3) = [  81, 86, 85 ]
    geom.face(170).n_poi = 3; allocate(geom.face(170).poi(3)); geom.face(170).poi(1:3) = [  85, 86, 90 ]
    geom.face(171).n_poi = 3; allocate(geom.face(171).poi(3)); geom.face(171).poi(1:3) = [  86, 87, 91 ]
    geom.face(172).n_poi = 3; allocate(geom.face(172).poi(3)); geom.face(172).poi(1:3) = [  91, 87, 92 ]
    geom.face(173).n_poi = 3; allocate(geom.face(173).poi(3)); geom.face(173).poi(1:3) = [  87, 88, 92 ]
    geom.face(174).n_poi = 3; allocate(geom.face(174).poi(3)); geom.face(174).poi(1:3) = [  92, 88, 93 ]
    geom.face(175).n_poi = 3; allocate(geom.face(175).poi(3)); geom.face(175).poi(1:3) = [  88, 89, 93 ]
    geom.face(176).n_poi = 3; allocate(geom.face(176).poi(3)); geom.face(176).poi(1:3) = [  93, 89, 94 ]
    geom.face(177).n_poi = 3; allocate(geom.face(177).poi(3)); geom.face(177).poi(1:3) = [  90, 95, 89 ]
    geom.face(178).n_poi = 3; allocate(geom.face(178).poi(3)); geom.face(178).poi(1:3) = [  89, 95, 94 ]
    geom.face(179).n_poi = 3; allocate(geom.face(179).poi(3)); geom.face(179).poi(1:3) = [  86, 91, 90 ]
    geom.face(180).n_poi = 3; allocate(geom.face(180).poi(3)); geom.face(180).poi(1:3) = [  90, 91, 95 ]
    geom.face(181).n_poi = 3; allocate(geom.face(181).poi(3)); geom.face(181).poi(1:3) = [  91, 92, 96 ]
    geom.face(182).n_poi = 3; allocate(geom.face(182).poi(3)); geom.face(182).poi(1:3) = [  96, 92, 97 ]
    geom.face(183).n_poi = 3; allocate(geom.face(183).poi(3)); geom.face(183).poi(1:3) = [  92, 93, 97 ]
    geom.face(184).n_poi = 3; allocate(geom.face(184).poi(3)); geom.face(184).poi(1:3) = [  97, 93, 98 ]
    geom.face(185).n_poi = 3; allocate(geom.face(185).poi(3)); geom.face(185).poi(1:3) = [  93, 94, 98 ]
    geom.face(186).n_poi = 3; allocate(geom.face(186).poi(3)); geom.face(186).poi(1:3) = [  98, 94, 99 ]
    geom.face(187).n_poi = 3; allocate(geom.face(187).poi(3)); geom.face(187).poi(1:3) = [  95,100, 94 ]
    geom.face(188).n_poi = 3; allocate(geom.face(188).poi(3)); geom.face(188).poi(1:3) = [  94,100, 99 ]
    geom.face(189).n_poi = 3; allocate(geom.face(189).poi(3)); geom.face(189).poi(1:3) = [  91, 96, 95 ]
    geom.face(190).n_poi = 3; allocate(geom.face(190).poi(3)); geom.face(190).poi(1:3) = [  95, 96,100 ]
    geom.face(191).n_poi = 3; allocate(geom.face(191).poi(3)); geom.face(191).poi(1:3) = [  96, 97,101 ]
    geom.face(192).n_poi = 3; allocate(geom.face(192).poi(3)); geom.face(192).poi(1:3) = [ 101, 97,102 ]
    geom.face(193).n_poi = 3; allocate(geom.face(193).poi(3)); geom.face(193).poi(1:3) = [  97, 98,102 ]
    geom.face(194).n_poi = 3; allocate(geom.face(194).poi(3)); geom.face(194).poi(1:3) = [ 102, 98,103 ]
    geom.face(195).n_poi = 3; allocate(geom.face(195).poi(3)); geom.face(195).poi(1:3) = [  98, 99,103 ]
    geom.face(196).n_poi = 3; allocate(geom.face(196).poi(3)); geom.face(196).poi(1:3) = [ 103, 99,104 ]
    geom.face(197).n_poi = 3; allocate(geom.face(197).poi(3)); geom.face(197).poi(1:3) = [ 100,105, 99 ]
    geom.face(198).n_poi = 3; allocate(geom.face(198).poi(3)); geom.face(198).poi(1:3) = [  99,105,104 ]
    geom.face(199).n_poi = 3; allocate(geom.face(199).poi(3)); geom.face(199).poi(1:3) = [  96,101,100 ]
    geom.face(200).n_poi = 3; allocate(geom.face(200).poi(3)); geom.face(200).poi(1:3) = [ 100,101,105 ]
    geom.face(201).n_poi = 3; allocate(geom.face(201).poi(3)); geom.face(201).poi(1:3) = [   1,  9,  2 ]
    geom.face(202).n_poi = 3; allocate(geom.face(202).poi(3)); geom.face(202).poi(1:3) = [   9,  7,  2 ]
    geom.face(203).n_poi = 3; allocate(geom.face(203).poi(3)); geom.face(203).poi(1:3) = [   7,  5,  2 ]
    geom.face(204).n_poi = 3; allocate(geom.face(204).poi(3)); geom.face(204).poi(1:3) = [ 101,102,105 ]
    geom.face(205).n_poi = 3; allocate(geom.face(205).poi(3)); geom.face(205).poi(1:3) = [ 102,103,105 ]
    geom.face(206).n_poi = 3; allocate(geom.face(206).poi(3)); geom.face(206).poi(1:3) = [ 103,104,105 ]
end subroutine Exam_Asym_Helix

! -----------------------------------------------------------------------------

! Example of Rod
subroutine Exam_Asym_Rod(prob, geom)
    type(ProbType), intent(inout) :: prob
    type(GeomType), intent(inout) :: geom

    character(10) :: char_sec, char_bp, char_start_bp

    write(unit=char_sec,      fmt = "(i10)"), prob.sel_sec
    write(unit=char_bp,       fmt = "(i10)"), prob.n_bp_edge
    write(unit=char_start_bp, fmt = "(i10)"), para_start_bp_ID

    prob.name_prob = "Rod"
    prob.name_file = "Rod"//&
        "_"//trim(adjustl(trim(char_sec)))//"cs"//&
        "_"//trim(adjustl(trim(char_bp)))//"bp"//&
        "_"//trim(para_vertex_design)

    ! Problem specified preset parameters
    if(para_vertex_design == "flat" .and. para_preset == "on") then
        para_junc_ang        = "max"    ! Junction gap modification for different arm angle
        para_const_edge_mesh = "off"    ! Constant edge length from polyhedra mesh
        para_unpaired_scaf   = "off"    ! Unpaired scaffold nucleotides
        para_n_base_tn       = 7
    end if

    ! Set geometric type and view (atom, cylinder size, move_x, move_y)
    call Mani_Set_View_Color(prob, [195, 153, 107], "xyz")

    ! Allocate point and face structure
    geom.n_iniP = 105
    geom.n_face = 206

    allocate(geom.iniP(geom.n_iniP))
    allocate(geom.face(geom.n_face))

    ! Set point position vectors
    geom.iniP(  1).pos(1:3) = [  2.62816d0, -100.00590d0, -8.09048d0 ]; geom.iniP(  2).pos(1:3) = [ -6.88241d0, -100.00590d0, -5.00030d0 ]
    geom.iniP(  3).pos(1:3) = [ -6.88241d0, -100.00590d0,  5.00030d0 ]; geom.iniP(  4).pos(1:3) = [  2.62816d0, -100.00590d0,  8.09048d0 ]
    geom.iniP(  5).pos(1:3) = [  8.50850d0, -100.00590d0,  0.00000d0 ]; geom.iniP(  6).pos(1:3) = [  2.62816d0,  -90.00531d0, -8.09048d0 ]
    geom.iniP(  7).pos(1:3) = [ -6.88241d0,  -90.00531d0, -5.00030d0 ]; geom.iniP(  8).pos(1:3) = [ -6.88241d0,  -90.00531d0,  5.00030d0 ]
    geom.iniP(  9).pos(1:3) = [  2.62816d0,  -90.00531d0,  8.09048d0 ]; geom.iniP( 10).pos(1:3) = [  8.50850d0,  -90.00531d0,  0.00000d0 ]
    geom.iniP( 11).pos(1:3) = [  2.62816d0,  -80.00472d0, -8.09048d0 ]; geom.iniP( 12).pos(1:3) = [ -6.88241d0,  -80.00472d0, -5.00030d0 ]
    geom.iniP( 13).pos(1:3) = [ -6.88241d0,  -80.00472d0,  5.00030d0 ]; geom.iniP( 14).pos(1:3) = [  2.62816d0,  -80.00472d0,  8.09048d0 ]
    geom.iniP( 15).pos(1:3) = [  8.50850d0,  -80.00472d0,  0.00000d0 ]; geom.iniP( 16).pos(1:3) = [  2.62816d0,  -70.00413d0, -8.09048d0 ]
    geom.iniP( 17).pos(1:3) = [ -6.88241d0,  -70.00413d0, -5.00030d0 ]; geom.iniP( 18).pos(1:3) = [ -6.88241d0,  -70.00413d0,  5.00030d0 ]
    geom.iniP( 19).pos(1:3) = [  2.62816d0,  -70.00413d0,  8.09048d0 ]; geom.iniP( 20).pos(1:3) = [  8.50850d0,  -70.00413d0,  0.00000d0 ]
    geom.iniP( 21).pos(1:3) = [  2.62816d0,  -60.00354d0, -8.09048d0 ]; geom.iniP( 22).pos(1:3) = [ -6.88241d0,  -60.00354d0, -5.00030d0 ]
    geom.iniP( 23).pos(1:3) = [ -6.88241d0,  -60.00354d0,  5.00030d0 ]; geom.iniP( 24).pos(1:3) = [  2.62816d0,  -60.00354d0,  8.09048d0 ]
    geom.iniP( 25).pos(1:3) = [  8.50850d0,  -60.00354d0,  0.00000d0 ]; geom.iniP( 26).pos(1:3) = [  2.62816d0,  -50.00295d0, -8.09048d0 ]
    geom.iniP( 27).pos(1:3) = [ -6.88241d0,  -50.00295d0, -5.00030d0 ]; geom.iniP( 28).pos(1:3) = [ -6.88241d0,  -50.00295d0,  5.00030d0 ]
    geom.iniP( 29).pos(1:3) = [  2.62816d0,  -50.00295d0,  8.09048d0 ]; geom.iniP( 30).pos(1:3) = [  8.50850d0,  -50.00295d0,  0.00000d0 ]
    geom.iniP( 31).pos(1:3) = [  2.62816d0,  -40.00236d0, -8.09048d0 ]; geom.iniP( 32).pos(1:3) = [ -6.88241d0,  -40.00236d0, -5.00030d0 ]
    geom.iniP( 33).pos(1:3) = [ -6.88241d0,  -40.00236d0,  5.00030d0 ]; geom.iniP( 34).pos(1:3) = [  2.62816d0,  -40.00236d0,  8.09048d0 ]
    geom.iniP( 35).pos(1:3) = [  8.50850d0,  -40.00236d0,  0.00000d0 ]; geom.iniP( 36).pos(1:3) = [  2.62816d0,  -30.00177d0, -8.09048d0 ]
    geom.iniP( 37).pos(1:3) = [ -6.88241d0,  -30.00177d0, -5.00030d0 ]; geom.iniP( 38).pos(1:3) = [ -6.88241d0,  -30.00177d0,  5.00030d0 ]
    geom.iniP( 39).pos(1:3) = [  2.62816d0,  -30.00177d0,  8.09048d0 ]; geom.iniP( 40).pos(1:3) = [  8.50850d0,  -30.00177d0,  0.00000d0 ]
    geom.iniP( 41).pos(1:3) = [  2.62816d0,  -20.00118d0, -8.09048d0 ]; geom.iniP( 42).pos(1:3) = [ -6.88241d0,  -20.00118d0, -5.00030d0 ]
    geom.iniP( 43).pos(1:3) = [ -6.88241d0,  -20.00118d0,  5.00030d0 ]; geom.iniP( 44).pos(1:3) = [  2.62816d0,  -20.00118d0,  8.09048d0 ]
    geom.iniP( 45).pos(1:3) = [  8.50850d0,  -20.00118d0,  0.00000d0 ]; geom.iniP( 46).pos(1:3) = [  2.62816d0,  -10.00059d0, -8.09048d0 ]
    geom.iniP( 47).pos(1:3) = [ -6.88241d0,  -10.00059d0, -5.00030d0 ]; geom.iniP( 48).pos(1:3) = [ -6.88241d0,  -10.00059d0,  5.00030d0 ]
    geom.iniP( 49).pos(1:3) = [  2.62816d0,  -10.00059d0,  8.09048d0 ]; geom.iniP( 50).pos(1:3) = [  8.50850d0,  -10.00059d0,  0.00000d0 ]
    geom.iniP( 51).pos(1:3) = [  2.62816d0,    0.00000d0, -8.09048d0 ]; geom.iniP( 52).pos(1:3) = [ -6.88241d0,    0.00000d0, -5.00030d0 ]
    geom.iniP( 53).pos(1:3) = [ -6.88241d0,    0.00000d0,  5.00030d0 ]; geom.iniP( 54).pos(1:3) = [  2.62816d0,    0.00000d0,  8.09048d0 ]
    geom.iniP( 55).pos(1:3) = [  8.50850d0,    0.00000d0,  0.00000d0 ]; geom.iniP( 56).pos(1:3) = [  2.62816d0,   10.00059d0, -8.09048d0 ]
    geom.iniP( 57).pos(1:3) = [ -6.88241d0,   10.00059d0, -5.00030d0 ]; geom.iniP( 58).pos(1:3) = [ -6.88241d0,   10.00059d0,  5.00030d0 ]
    geom.iniP( 59).pos(1:3) = [  2.62816d0,   10.00059d0,  8.09048d0 ]; geom.iniP( 60).pos(1:3) = [  8.50850d0,   10.00059d0,  0.00000d0 ]
    geom.iniP( 61).pos(1:3) = [  2.62816d0,   20.00118d0, -8.09048d0 ]; geom.iniP( 62).pos(1:3) = [ -6.88241d0,   20.00118d0, -5.00030d0 ]
    geom.iniP( 63).pos(1:3) = [ -6.88241d0,   20.00118d0,  5.00030d0 ]; geom.iniP( 64).pos(1:3) = [  2.62816d0,   20.00118d0,  8.09048d0 ]
    geom.iniP( 65).pos(1:3) = [  8.50850d0,   20.00118d0,  0.00000d0 ]; geom.iniP( 66).pos(1:3) = [  2.62816d0,   30.00177d0, -8.09048d0 ]
    geom.iniP( 67).pos(1:3) = [ -6.88241d0,   30.00177d0, -5.00030d0 ]; geom.iniP( 68).pos(1:3) = [ -6.88241d0,   30.00177d0,  5.00030d0 ]
    geom.iniP( 69).pos(1:3) = [  2.62816d0,   30.00177d0,  8.09048d0 ]; geom.iniP( 70).pos(1:3) = [  8.50850d0,   30.00177d0,  0.00000d0 ]
    geom.iniP( 71).pos(1:3) = [  2.62816d0,   40.00236d0, -8.09048d0 ]; geom.iniP( 72).pos(1:3) = [ -6.88241d0,   40.00236d0, -5.00030d0 ]
    geom.iniP( 73).pos(1:3) = [ -6.88241d0,   40.00236d0,  5.00030d0 ]; geom.iniP( 74).pos(1:3) = [  2.62816d0,   40.00236d0,  8.09048d0 ]
    geom.iniP( 75).pos(1:3) = [  8.50850d0,   40.00236d0,  0.00000d0 ]; geom.iniP( 76).pos(1:3) = [  2.62816d0,   50.00295d0, -8.09048d0 ]
    geom.iniP( 77).pos(1:3) = [ -6.88241d0,   50.00295d0, -5.00030d0 ]; geom.iniP( 78).pos(1:3) = [ -6.88241d0,   50.00295d0,  5.00030d0 ]
    geom.iniP( 79).pos(1:3) = [  2.62816d0,   50.00295d0,  8.09048d0 ]; geom.iniP( 80).pos(1:3) = [  8.50850d0,   50.00295d0,  0.00000d0 ]
    geom.iniP( 81).pos(1:3) = [  2.62816d0,   60.00354d0, -8.09048d0 ]; geom.iniP( 82).pos(1:3) = [ -6.88241d0,   60.00354d0, -5.00030d0 ]
    geom.iniP( 83).pos(1:3) = [ -6.88241d0,   60.00354d0,  5.00030d0 ]; geom.iniP( 84).pos(1:3) = [  2.62816d0,   60.00354d0,  8.09048d0 ]
    geom.iniP( 85).pos(1:3) = [  8.50850d0,   60.00354d0,  0.00000d0 ]; geom.iniP( 86).pos(1:3) = [  2.62816d0,   70.00413d0, -8.09048d0 ]
    geom.iniP( 87).pos(1:3) = [ -6.88241d0,   70.00413d0, -5.00030d0 ]; geom.iniP( 88).pos(1:3) = [ -6.88241d0,   70.00413d0,  5.00030d0 ]
    geom.iniP( 89).pos(1:3) = [  2.62816d0,   70.00413d0,  8.09048d0 ]; geom.iniP( 90).pos(1:3) = [  8.50850d0,   70.00413d0,  0.00000d0 ]
    geom.iniP( 91).pos(1:3) = [  2.62816d0,   80.00472d0, -8.09048d0 ]; geom.iniP( 92).pos(1:3) = [ -6.88241d0,   80.00472d0, -5.00030d0 ]
    geom.iniP( 93).pos(1:3) = [ -6.88241d0,   80.00472d0,  5.00030d0 ]; geom.iniP( 94).pos(1:3) = [  2.62816d0,   80.00472d0,  8.09048d0 ]
    geom.iniP( 95).pos(1:3) = [  8.50850d0,   80.00472d0,  0.00000d0 ]; geom.iniP( 96).pos(1:3) = [  2.62816d0,   90.00531d0, -8.09048d0 ]
    geom.iniP( 97).pos(1:3) = [ -6.88241d0,   90.00531d0, -5.00030d0 ]; geom.iniP( 98).pos(1:3) = [ -6.88241d0,   90.00531d0,  5.00030d0 ]
    geom.iniP( 99).pos(1:3) = [  2.62816d0,   90.00531d0,  8.09048d0 ]; geom.iniP(100).pos(1:3) = [  8.50850d0,   90.00531d0,  0.00000d0 ]
    geom.iniP(101).pos(1:3) = [  2.62816d0,  100.00590d0, -8.09048d0 ]; geom.iniP(102).pos(1:3) = [ -6.88241d0,  100.00590d0, -5.00030d0 ]
    geom.iniP(103).pos(1:3) = [ -6.88241d0,  100.00590d0,  5.00030d0 ]; geom.iniP(104).pos(1:3) = [  2.62816d0,  100.00590d0,  8.09048d0 ]
    geom.iniP(105).pos(1:3) = [  8.50850d0,  100.00590d0,  0.00000d0 ]

    ! Set face connnectivity
    geom.face(  1).n_poi = 3; allocate(geom.face(  1).poi(3)); geom.face(  1).poi(1:3) = [   1,   2,   6 ]
    geom.face(  2).n_poi = 3; allocate(geom.face(  2).poi(3)); geom.face(  2).poi(1:3) = [   6,   2,   7 ]
    geom.face(  3).n_poi = 3; allocate(geom.face(  3).poi(3)); geom.face(  3).poi(1:3) = [   2,   3,   7 ]
    geom.face(  4).n_poi = 3; allocate(geom.face(  4).poi(3)); geom.face(  4).poi(1:3) = [   7,   3,   8 ]
    geom.face(  5).n_poi = 3; allocate(geom.face(  5).poi(3)); geom.face(  5).poi(1:3) = [   3,   4,   8 ]
    geom.face(  6).n_poi = 3; allocate(geom.face(  6).poi(3)); geom.face(  6).poi(1:3) = [   8,   4,   9 ]
    geom.face(  7).n_poi = 3; allocate(geom.face(  7).poi(3)); geom.face(  7).poi(1:3) = [   4,   5,   9 ]
    geom.face(  8).n_poi = 3; allocate(geom.face(  8).poi(3)); geom.face(  8).poi(1:3) = [   9,   5,  10 ]
    geom.face(  9).n_poi = 3; allocate(geom.face(  9).poi(3)); geom.face(  9).poi(1:3) = [   5,   1,  10 ]
    geom.face( 10).n_poi = 3; allocate(geom.face( 10).poi(3)); geom.face( 10).poi(1:3) = [  10,   1,   6 ]
    geom.face( 11).n_poi = 3; allocate(geom.face( 11).poi(3)); geom.face( 11).poi(1:3) = [   6,   7,  11 ]
    geom.face( 12).n_poi = 3; allocate(geom.face( 12).poi(3)); geom.face( 12).poi(1:3) = [  11,   7,  12 ]
    geom.face( 13).n_poi = 3; allocate(geom.face( 13).poi(3)); geom.face( 13).poi(1:3) = [   7,   8,  12 ]
    geom.face( 14).n_poi = 3; allocate(geom.face( 14).poi(3)); geom.face( 14).poi(1:3) = [  12,   8,  13 ]
    geom.face( 15).n_poi = 3; allocate(geom.face( 15).poi(3)); geom.face( 15).poi(1:3) = [   8,   9,  13 ]
    geom.face( 16).n_poi = 3; allocate(geom.face( 16).poi(3)); geom.face( 16).poi(1:3) = [  13,   9,  14 ]
    geom.face( 17).n_poi = 3; allocate(geom.face( 17).poi(3)); geom.face( 17).poi(1:3) = [   9,  10,  14 ]
    geom.face( 18).n_poi = 3; allocate(geom.face( 18).poi(3)); geom.face( 18).poi(1:3) = [  14,  10,  15 ]
    geom.face( 19).n_poi = 3; allocate(geom.face( 19).poi(3)); geom.face( 19).poi(1:3) = [  10,   6,  15 ]
    geom.face( 20).n_poi = 3; allocate(geom.face( 20).poi(3)); geom.face( 20).poi(1:3) = [  15,   6,  11 ]
    geom.face( 21).n_poi = 3; allocate(geom.face( 21).poi(3)); geom.face( 21).poi(1:3) = [  11,  12,  16 ]
    geom.face( 22).n_poi = 3; allocate(geom.face( 22).poi(3)); geom.face( 22).poi(1:3) = [  16,  12,  17 ]
    geom.face( 23).n_poi = 3; allocate(geom.face( 23).poi(3)); geom.face( 23).poi(1:3) = [  12,  13,  17 ]
    geom.face( 24).n_poi = 3; allocate(geom.face( 24).poi(3)); geom.face( 24).poi(1:3) = [  17,  13,  18 ]
    geom.face( 25).n_poi = 3; allocate(geom.face( 25).poi(3)); geom.face( 25).poi(1:3) = [  13,  14,  18 ]
    geom.face( 26).n_poi = 3; allocate(geom.face( 26).poi(3)); geom.face( 26).poi(1:3) = [  18,  14,  19 ]
    geom.face( 27).n_poi = 3; allocate(geom.face( 27).poi(3)); geom.face( 27).poi(1:3) = [  14,  15,  19 ]
    geom.face( 28).n_poi = 3; allocate(geom.face( 28).poi(3)); geom.face( 28).poi(1:3) = [  19,  15,  20 ]
    geom.face( 29).n_poi = 3; allocate(geom.face( 29).poi(3)); geom.face( 29).poi(1:3) = [  15,  11,  20 ]
    geom.face( 30).n_poi = 3; allocate(geom.face( 30).poi(3)); geom.face( 30).poi(1:3) = [  20,  11,  16 ]
    geom.face( 31).n_poi = 3; allocate(geom.face( 31).poi(3)); geom.face( 31).poi(1:3) = [  16,  17,  21 ]
    geom.face( 32).n_poi = 3; allocate(geom.face( 32).poi(3)); geom.face( 32).poi(1:3) = [  21,  17,  22 ]
    geom.face( 33).n_poi = 3; allocate(geom.face( 33).poi(3)); geom.face( 33).poi(1:3) = [  17,  18,  22 ]
    geom.face( 34).n_poi = 3; allocate(geom.face( 34).poi(3)); geom.face( 34).poi(1:3) = [  22,  18,  23 ]
    geom.face( 35).n_poi = 3; allocate(geom.face( 35).poi(3)); geom.face( 35).poi(1:3) = [  18,  19,  23 ]
    geom.face( 36).n_poi = 3; allocate(geom.face( 36).poi(3)); geom.face( 36).poi(1:3) = [  23,  19,  24 ]
    geom.face( 37).n_poi = 3; allocate(geom.face( 37).poi(3)); geom.face( 37).poi(1:3) = [  19,  20,  24 ]
    geom.face( 38).n_poi = 3; allocate(geom.face( 38).poi(3)); geom.face( 38).poi(1:3) = [  24,  20,  25 ]
    geom.face( 39).n_poi = 3; allocate(geom.face( 39).poi(3)); geom.face( 39).poi(1:3) = [  20,  16,  25 ]
    geom.face( 40).n_poi = 3; allocate(geom.face( 40).poi(3)); geom.face( 40).poi(1:3) = [  25,  16,  21 ]
    geom.face( 41).n_poi = 3; allocate(geom.face( 41).poi(3)); geom.face( 41).poi(1:3) = [  21,  22,  26 ]
    geom.face( 42).n_poi = 3; allocate(geom.face( 42).poi(3)); geom.face( 42).poi(1:3) = [  26,  22,  27 ]
    geom.face( 43).n_poi = 3; allocate(geom.face( 43).poi(3)); geom.face( 43).poi(1:3) = [  22,  23,  27 ]
    geom.face( 44).n_poi = 3; allocate(geom.face( 44).poi(3)); geom.face( 44).poi(1:3) = [  27,  23,  28 ]
    geom.face( 45).n_poi = 3; allocate(geom.face( 45).poi(3)); geom.face( 45).poi(1:3) = [  23,  24,  28 ]
    geom.face( 46).n_poi = 3; allocate(geom.face( 46).poi(3)); geom.face( 46).poi(1:3) = [  28,  24,  29 ]
    geom.face( 47).n_poi = 3; allocate(geom.face( 47).poi(3)); geom.face( 47).poi(1:3) = [  24,  25,  29 ]
    geom.face( 48).n_poi = 3; allocate(geom.face( 48).poi(3)); geom.face( 48).poi(1:3) = [  29,  25,  30 ]
    geom.face( 49).n_poi = 3; allocate(geom.face( 49).poi(3)); geom.face( 49).poi(1:3) = [  25,  21,  30 ]
    geom.face( 50).n_poi = 3; allocate(geom.face( 50).poi(3)); geom.face( 50).poi(1:3) = [  30,  21,  26 ]
    geom.face( 51).n_poi = 3; allocate(geom.face( 51).poi(3)); geom.face( 51).poi(1:3) = [  26,  27,  31 ]
    geom.face( 52).n_poi = 3; allocate(geom.face( 52).poi(3)); geom.face( 52).poi(1:3) = [  31,  27,  32 ]
    geom.face( 53).n_poi = 3; allocate(geom.face( 53).poi(3)); geom.face( 53).poi(1:3) = [  27,  28,  32 ]
    geom.face( 54).n_poi = 3; allocate(geom.face( 54).poi(3)); geom.face( 54).poi(1:3) = [  32,  28,  33 ]
    geom.face( 55).n_poi = 3; allocate(geom.face( 55).poi(3)); geom.face( 55).poi(1:3) = [  28,  29,  33 ]
    geom.face( 56).n_poi = 3; allocate(geom.face( 56).poi(3)); geom.face( 56).poi(1:3) = [  33,  29,  34 ]
    geom.face( 57).n_poi = 3; allocate(geom.face( 57).poi(3)); geom.face( 57).poi(1:3) = [  29,  30,  34 ]
    geom.face( 58).n_poi = 3; allocate(geom.face( 58).poi(3)); geom.face( 58).poi(1:3) = [  34,  30,  35 ]
    geom.face( 59).n_poi = 3; allocate(geom.face( 59).poi(3)); geom.face( 59).poi(1:3) = [  30,  26,  35 ]
    geom.face( 60).n_poi = 3; allocate(geom.face( 60).poi(3)); geom.face( 60).poi(1:3) = [  35,  26,  31 ]
    geom.face( 61).n_poi = 3; allocate(geom.face( 61).poi(3)); geom.face( 61).poi(1:3) = [  31,  32,  36 ]
    geom.face( 62).n_poi = 3; allocate(geom.face( 62).poi(3)); geom.face( 62).poi(1:3) = [  36,  32,  37 ]
    geom.face( 63).n_poi = 3; allocate(geom.face( 63).poi(3)); geom.face( 63).poi(1:3) = [  32,  33,  37 ]
    geom.face( 64).n_poi = 3; allocate(geom.face( 64).poi(3)); geom.face( 64).poi(1:3) = [  37,  33,  38 ]
    geom.face( 65).n_poi = 3; allocate(geom.face( 65).poi(3)); geom.face( 65).poi(1:3) = [  33,  34,  38 ]
    geom.face( 66).n_poi = 3; allocate(geom.face( 66).poi(3)); geom.face( 66).poi(1:3) = [  38,  34,  39 ]
    geom.face( 67).n_poi = 3; allocate(geom.face( 67).poi(3)); geom.face( 67).poi(1:3) = [  34,  35,  39 ]
    geom.face( 68).n_poi = 3; allocate(geom.face( 68).poi(3)); geom.face( 68).poi(1:3) = [  39,  35,  40 ]
    geom.face( 69).n_poi = 3; allocate(geom.face( 69).poi(3)); geom.face( 69).poi(1:3) = [  35,  31,  40 ]
    geom.face( 70).n_poi = 3; allocate(geom.face( 70).poi(3)); geom.face( 70).poi(1:3) = [  40,  31,  36 ]
    geom.face( 71).n_poi = 3; allocate(geom.face( 71).poi(3)); geom.face( 71).poi(1:3) = [  36,  37,  41 ]
    geom.face( 72).n_poi = 3; allocate(geom.face( 72).poi(3)); geom.face( 72).poi(1:3) = [  41,  37,  42 ]
    geom.face( 73).n_poi = 3; allocate(geom.face( 73).poi(3)); geom.face( 73).poi(1:3) = [  37,  38,  42 ]
    geom.face( 74).n_poi = 3; allocate(geom.face( 74).poi(3)); geom.face( 74).poi(1:3) = [  42,  38,  43 ]
    geom.face( 75).n_poi = 3; allocate(geom.face( 75).poi(3)); geom.face( 75).poi(1:3) = [  38,  39,  43 ]
    geom.face( 76).n_poi = 3; allocate(geom.face( 76).poi(3)); geom.face( 76).poi(1:3) = [  43,  39,  44 ]
    geom.face( 77).n_poi = 3; allocate(geom.face( 77).poi(3)); geom.face( 77).poi(1:3) = [  39,  40,  44 ]
    geom.face( 78).n_poi = 3; allocate(geom.face( 78).poi(3)); geom.face( 78).poi(1:3) = [  44,  40,  45 ]
    geom.face( 79).n_poi = 3; allocate(geom.face( 79).poi(3)); geom.face( 79).poi(1:3) = [  40,  36,  45 ]
    geom.face( 80).n_poi = 3; allocate(geom.face( 80).poi(3)); geom.face( 80).poi(1:3) = [  45,  36,  41 ]
    geom.face( 81).n_poi = 3; allocate(geom.face( 81).poi(3)); geom.face( 81).poi(1:3) = [  41,  42,  46 ]
    geom.face( 82).n_poi = 3; allocate(geom.face( 82).poi(3)); geom.face( 82).poi(1:3) = [  46,  42,  47 ]
    geom.face( 83).n_poi = 3; allocate(geom.face( 83).poi(3)); geom.face( 83).poi(1:3) = [  42,  43,  47 ]
    geom.face( 84).n_poi = 3; allocate(geom.face( 84).poi(3)); geom.face( 84).poi(1:3) = [  47,  43,  48 ]
    geom.face( 85).n_poi = 3; allocate(geom.face( 85).poi(3)); geom.face( 85).poi(1:3) = [  43,  44,  48 ]
    geom.face( 86).n_poi = 3; allocate(geom.face( 86).poi(3)); geom.face( 86).poi(1:3) = [  48,  44,  49 ]
    geom.face( 87).n_poi = 3; allocate(geom.face( 87).poi(3)); geom.face( 87).poi(1:3) = [  44,  45,  49 ]
    geom.face( 88).n_poi = 3; allocate(geom.face( 88).poi(3)); geom.face( 88).poi(1:3) = [  49,  45,  50 ]
    geom.face( 89).n_poi = 3; allocate(geom.face( 89).poi(3)); geom.face( 89).poi(1:3) = [  45,  41,  50 ]
    geom.face( 90).n_poi = 3; allocate(geom.face( 90).poi(3)); geom.face( 90).poi(1:3) = [  50,  41,  46 ]
    geom.face( 91).n_poi = 3; allocate(geom.face( 91).poi(3)); geom.face( 91).poi(1:3) = [  46,  47,  51 ]
    geom.face( 92).n_poi = 3; allocate(geom.face( 92).poi(3)); geom.face( 92).poi(1:3) = [  51,  47,  52 ]
    geom.face( 93).n_poi = 3; allocate(geom.face( 93).poi(3)); geom.face( 93).poi(1:3) = [  47,  48,  52 ]
    geom.face( 94).n_poi = 3; allocate(geom.face( 94).poi(3)); geom.face( 94).poi(1:3) = [  52,  48,  53 ]
    geom.face( 95).n_poi = 3; allocate(geom.face( 95).poi(3)); geom.face( 95).poi(1:3) = [  48,  49,  53 ]
    geom.face( 96).n_poi = 3; allocate(geom.face( 96).poi(3)); geom.face( 96).poi(1:3) = [  53,  49,  54 ]
    geom.face( 97).n_poi = 3; allocate(geom.face( 97).poi(3)); geom.face( 97).poi(1:3) = [  49,  50,  54 ]
    geom.face( 98).n_poi = 3; allocate(geom.face( 98).poi(3)); geom.face( 98).poi(1:3) = [  54,  50,  55 ]
    geom.face( 99).n_poi = 3; allocate(geom.face( 99).poi(3)); geom.face( 99).poi(1:3) = [  50,  46,  55 ]
    geom.face(100).n_poi = 3; allocate(geom.face(100).poi(3)); geom.face(100).poi(1:3) = [  55,  46,  51 ]
    geom.face(101).n_poi = 3; allocate(geom.face(101).poi(3)); geom.face(101).poi(1:3) = [  51,  52,  56 ]
    geom.face(102).n_poi = 3; allocate(geom.face(102).poi(3)); geom.face(102).poi(1:3) = [  56,  52,  57 ]
    geom.face(103).n_poi = 3; allocate(geom.face(103).poi(3)); geom.face(103).poi(1:3) = [  52,  53,  57 ]
    geom.face(104).n_poi = 3; allocate(geom.face(104).poi(3)); geom.face(104).poi(1:3) = [  57,  53,  58 ]
    geom.face(105).n_poi = 3; allocate(geom.face(105).poi(3)); geom.face(105).poi(1:3) = [  53,  54,  58 ]
    geom.face(106).n_poi = 3; allocate(geom.face(106).poi(3)); geom.face(106).poi(1:3) = [  58,  54,  59 ]
    geom.face(107).n_poi = 3; allocate(geom.face(107).poi(3)); geom.face(107).poi(1:3) = [  54,  55,  59 ]
    geom.face(108).n_poi = 3; allocate(geom.face(108).poi(3)); geom.face(108).poi(1:3) = [  59,  55,  60 ]
    geom.face(109).n_poi = 3; allocate(geom.face(109).poi(3)); geom.face(109).poi(1:3) = [  55,  51,  60 ]
    geom.face(110).n_poi = 3; allocate(geom.face(110).poi(3)); geom.face(110).poi(1:3) = [  60,  51,  56 ]
    geom.face(111).n_poi = 3; allocate(geom.face(111).poi(3)); geom.face(111).poi(1:3) = [  56,  57,  61 ]
    geom.face(112).n_poi = 3; allocate(geom.face(112).poi(3)); geom.face(112).poi(1:3) = [  61,  57,  62 ]
    geom.face(113).n_poi = 3; allocate(geom.face(113).poi(3)); geom.face(113).poi(1:3) = [  57,  58,  62 ]
    geom.face(114).n_poi = 3; allocate(geom.face(114).poi(3)); geom.face(114).poi(1:3) = [  62,  58,  63 ]
    geom.face(115).n_poi = 3; allocate(geom.face(115).poi(3)); geom.face(115).poi(1:3) = [  58,  59,  63 ]
    geom.face(116).n_poi = 3; allocate(geom.face(116).poi(3)); geom.face(116).poi(1:3) = [  63,  59,  64 ]
    geom.face(117).n_poi = 3; allocate(geom.face(117).poi(3)); geom.face(117).poi(1:3) = [  59,  60,  64 ]
    geom.face(118).n_poi = 3; allocate(geom.face(118).poi(3)); geom.face(118).poi(1:3) = [  64,  60,  65 ]
    geom.face(119).n_poi = 3; allocate(geom.face(119).poi(3)); geom.face(119).poi(1:3) = [  60,  56,  65 ]
    geom.face(120).n_poi = 3; allocate(geom.face(120).poi(3)); geom.face(120).poi(1:3) = [  65,  56,  61 ]
    geom.face(121).n_poi = 3; allocate(geom.face(121).poi(3)); geom.face(121).poi(1:3) = [  61,  62,  66 ]
    geom.face(122).n_poi = 3; allocate(geom.face(122).poi(3)); geom.face(122).poi(1:3) = [  66,  62,  67 ]
    geom.face(123).n_poi = 3; allocate(geom.face(123).poi(3)); geom.face(123).poi(1:3) = [  62,  63,  67 ]
    geom.face(124).n_poi = 3; allocate(geom.face(124).poi(3)); geom.face(124).poi(1:3) = [  67,  63,  68 ]
    geom.face(125).n_poi = 3; allocate(geom.face(125).poi(3)); geom.face(125).poi(1:3) = [  63,  64,  68 ]
    geom.face(126).n_poi = 3; allocate(geom.face(126).poi(3)); geom.face(126).poi(1:3) = [  68,  64,  69 ]
    geom.face(127).n_poi = 3; allocate(geom.face(127).poi(3)); geom.face(127).poi(1:3) = [  64,  65,  69 ]
    geom.face(128).n_poi = 3; allocate(geom.face(128).poi(3)); geom.face(128).poi(1:3) = [  69,  65,  70 ]
    geom.face(129).n_poi = 3; allocate(geom.face(129).poi(3)); geom.face(129).poi(1:3) = [  65,  61,  70 ]
    geom.face(130).n_poi = 3; allocate(geom.face(130).poi(3)); geom.face(130).poi(1:3) = [  70,  61,  66 ]
    geom.face(131).n_poi = 3; allocate(geom.face(131).poi(3)); geom.face(131).poi(1:3) = [  66,  67,  71 ]
    geom.face(132).n_poi = 3; allocate(geom.face(132).poi(3)); geom.face(132).poi(1:3) = [  71,  67,  72 ]
    geom.face(133).n_poi = 3; allocate(geom.face(133).poi(3)); geom.face(133).poi(1:3) = [  67,  68,  72 ]
    geom.face(134).n_poi = 3; allocate(geom.face(134).poi(3)); geom.face(134).poi(1:3) = [  72,  68,  73 ]
    geom.face(135).n_poi = 3; allocate(geom.face(135).poi(3)); geom.face(135).poi(1:3) = [  68,  69,  73 ]
    geom.face(136).n_poi = 3; allocate(geom.face(136).poi(3)); geom.face(136).poi(1:3) = [  73,  69,  74 ]
    geom.face(137).n_poi = 3; allocate(geom.face(137).poi(3)); geom.face(137).poi(1:3) = [  69,  70,  74 ]
    geom.face(138).n_poi = 3; allocate(geom.face(138).poi(3)); geom.face(138).poi(1:3) = [  74,  70,  75 ]
    geom.face(139).n_poi = 3; allocate(geom.face(139).poi(3)); geom.face(139).poi(1:3) = [  70,  66,  75 ]
    geom.face(140).n_poi = 3; allocate(geom.face(140).poi(3)); geom.face(140).poi(1:3) = [  75,  66,  71 ]
    geom.face(141).n_poi = 3; allocate(geom.face(141).poi(3)); geom.face(141).poi(1:3) = [  71,  72,  76 ]
    geom.face(142).n_poi = 3; allocate(geom.face(142).poi(3)); geom.face(142).poi(1:3) = [  76,  72,  77 ]
    geom.face(143).n_poi = 3; allocate(geom.face(143).poi(3)); geom.face(143).poi(1:3) = [  72,  73,  77 ]
    geom.face(144).n_poi = 3; allocate(geom.face(144).poi(3)); geom.face(144).poi(1:3) = [  77,  73,  78 ]
    geom.face(145).n_poi = 3; allocate(geom.face(145).poi(3)); geom.face(145).poi(1:3) = [  73,  74,  78 ]
    geom.face(146).n_poi = 3; allocate(geom.face(146).poi(3)); geom.face(146).poi(1:3) = [  78,  74,  79 ]
    geom.face(147).n_poi = 3; allocate(geom.face(147).poi(3)); geom.face(147).poi(1:3) = [  74,  75,  79 ]
    geom.face(148).n_poi = 3; allocate(geom.face(148).poi(3)); geom.face(148).poi(1:3) = [  79,  75,  80 ]
    geom.face(149).n_poi = 3; allocate(geom.face(149).poi(3)); geom.face(149).poi(1:3) = [  75,  71,  80 ]
    geom.face(150).n_poi = 3; allocate(geom.face(150).poi(3)); geom.face(150).poi(1:3) = [  80,  71,  76 ]
    geom.face(151).n_poi = 3; allocate(geom.face(151).poi(3)); geom.face(151).poi(1:3) = [  76,  77,  81 ]
    geom.face(152).n_poi = 3; allocate(geom.face(152).poi(3)); geom.face(152).poi(1:3) = [  81,  77,  82 ]
    geom.face(153).n_poi = 3; allocate(geom.face(153).poi(3)); geom.face(153).poi(1:3) = [  77,  78,  82 ]
    geom.face(154).n_poi = 3; allocate(geom.face(154).poi(3)); geom.face(154).poi(1:3) = [  82,  78,  83 ]
    geom.face(155).n_poi = 3; allocate(geom.face(155).poi(3)); geom.face(155).poi(1:3) = [  78,  79,  83 ]
    geom.face(156).n_poi = 3; allocate(geom.face(156).poi(3)); geom.face(156).poi(1:3) = [  83,  79,  84 ]
    geom.face(157).n_poi = 3; allocate(geom.face(157).poi(3)); geom.face(157).poi(1:3) = [  79,  80,  84 ]
    geom.face(158).n_poi = 3; allocate(geom.face(158).poi(3)); geom.face(158).poi(1:3) = [  84,  80,  85 ]
    geom.face(159).n_poi = 3; allocate(geom.face(159).poi(3)); geom.face(159).poi(1:3) = [  80,  76,  85 ]
    geom.face(160).n_poi = 3; allocate(geom.face(160).poi(3)); geom.face(160).poi(1:3) = [  85,  76,  81 ]
    geom.face(161).n_poi = 3; allocate(geom.face(161).poi(3)); geom.face(161).poi(1:3) = [  81,  82,  86 ]
    geom.face(162).n_poi = 3; allocate(geom.face(162).poi(3)); geom.face(162).poi(1:3) = [  86,  82,  87 ]
    geom.face(163).n_poi = 3; allocate(geom.face(163).poi(3)); geom.face(163).poi(1:3) = [  82,  83,  87 ]
    geom.face(164).n_poi = 3; allocate(geom.face(164).poi(3)); geom.face(164).poi(1:3) = [  87,  83,  88 ]
    geom.face(165).n_poi = 3; allocate(geom.face(165).poi(3)); geom.face(165).poi(1:3) = [  83,  84,  88 ]
    geom.face(166).n_poi = 3; allocate(geom.face(166).poi(3)); geom.face(166).poi(1:3) = [  88,  84,  89 ]
    geom.face(167).n_poi = 3; allocate(geom.face(167).poi(3)); geom.face(167).poi(1:3) = [  84,  85,  89 ]
    geom.face(168).n_poi = 3; allocate(geom.face(168).poi(3)); geom.face(168).poi(1:3) = [  89,  85,  90 ]
    geom.face(169).n_poi = 3; allocate(geom.face(169).poi(3)); geom.face(169).poi(1:3) = [  85,  81,  90 ]
    geom.face(170).n_poi = 3; allocate(geom.face(170).poi(3)); geom.face(170).poi(1:3) = [  90,  81,  86 ]
    geom.face(171).n_poi = 3; allocate(geom.face(171).poi(3)); geom.face(171).poi(1:3) = [  86,  87,  91 ]
    geom.face(172).n_poi = 3; allocate(geom.face(172).poi(3)); geom.face(172).poi(1:3) = [  91,  87,  92 ]
    geom.face(173).n_poi = 3; allocate(geom.face(173).poi(3)); geom.face(173).poi(1:3) = [  87,  88,  92 ]
    geom.face(174).n_poi = 3; allocate(geom.face(174).poi(3)); geom.face(174).poi(1:3) = [  92,  88,  93 ]
    geom.face(175).n_poi = 3; allocate(geom.face(175).poi(3)); geom.face(175).poi(1:3) = [  88,  89,  93 ]
    geom.face(176).n_poi = 3; allocate(geom.face(176).poi(3)); geom.face(176).poi(1:3) = [  93,  89,  94 ]
    geom.face(177).n_poi = 3; allocate(geom.face(177).poi(3)); geom.face(177).poi(1:3) = [  89,  90,  94 ]
    geom.face(178).n_poi = 3; allocate(geom.face(178).poi(3)); geom.face(178).poi(1:3) = [  94,  90,  95 ]
    geom.face(179).n_poi = 3; allocate(geom.face(179).poi(3)); geom.face(179).poi(1:3) = [  90,  86,  95 ]
    geom.face(180).n_poi = 3; allocate(geom.face(180).poi(3)); geom.face(180).poi(1:3) = [  95,  86,  91 ]
    geom.face(181).n_poi = 3; allocate(geom.face(181).poi(3)); geom.face(181).poi(1:3) = [  91,  92,  96 ]
    geom.face(182).n_poi = 3; allocate(geom.face(182).poi(3)); geom.face(182).poi(1:3) = [  96,  92,  97 ]
    geom.face(183).n_poi = 3; allocate(geom.face(183).poi(3)); geom.face(183).poi(1:3) = [  92,  93,  97 ]
    geom.face(184).n_poi = 3; allocate(geom.face(184).poi(3)); geom.face(184).poi(1:3) = [  97,  93,  98 ]
    geom.face(185).n_poi = 3; allocate(geom.face(185).poi(3)); geom.face(185).poi(1:3) = [  93,  94,  98 ]
    geom.face(186).n_poi = 3; allocate(geom.face(186).poi(3)); geom.face(186).poi(1:3) = [  98,  94,  99 ]
    geom.face(187).n_poi = 3; allocate(geom.face(187).poi(3)); geom.face(187).poi(1:3) = [  94,  95,  99 ]
    geom.face(188).n_poi = 3; allocate(geom.face(188).poi(3)); geom.face(188).poi(1:3) = [  99,  95, 100 ]
    geom.face(189).n_poi = 3; allocate(geom.face(189).poi(3)); geom.face(189).poi(1:3) = [  95,  91, 100 ]
    geom.face(190).n_poi = 3; allocate(geom.face(190).poi(3)); geom.face(190).poi(1:3) = [ 100,  91,  96 ]
    geom.face(191).n_poi = 3; allocate(geom.face(191).poi(3)); geom.face(191).poi(1:3) = [  96,  97, 101 ]
    geom.face(192).n_poi = 3; allocate(geom.face(192).poi(3)); geom.face(192).poi(1:3) = [ 101,  97, 102 ]
    geom.face(193).n_poi = 3; allocate(geom.face(193).poi(3)); geom.face(193).poi(1:3) = [  97,  98, 102 ]
    geom.face(194).n_poi = 3; allocate(geom.face(194).poi(3)); geom.face(194).poi(1:3) = [ 102,  98, 103 ]
    geom.face(195).n_poi = 3; allocate(geom.face(195).poi(3)); geom.face(195).poi(1:3) = [  98,  99, 103 ]
    geom.face(196).n_poi = 3; allocate(geom.face(196).poi(3)); geom.face(196).poi(1:3) = [ 103,  99, 104 ]
    geom.face(197).n_poi = 3; allocate(geom.face(197).poi(3)); geom.face(197).poi(1:3) = [  99, 100, 104 ]
    geom.face(198).n_poi = 3; allocate(geom.face(198).poi(3)); geom.face(198).poi(1:3) = [ 104, 100, 105 ]
    geom.face(199).n_poi = 3; allocate(geom.face(199).poi(3)); geom.face(199).poi(1:3) = [ 100,  96, 105 ]
    geom.face(200).n_poi = 3; allocate(geom.face(200).poi(3)); geom.face(200).poi(1:3) = [ 105,  96, 101 ]
    geom.face(201).n_poi = 3; allocate(geom.face(201).poi(3)); geom.face(201).poi(1:3) = [   1,   5,   2 ]
    geom.face(202).n_poi = 3; allocate(geom.face(202).poi(3)); geom.face(202).poi(1:3) = [   5,   4,   2 ]
    geom.face(203).n_poi = 3; allocate(geom.face(203).poi(3)); geom.face(203).poi(1:3) = [   4,   3,   2 ]
    geom.face(204).n_poi = 3; allocate(geom.face(204).poi(3)); geom.face(204).poi(1:3) = [ 101, 102, 105 ]
    geom.face(205).n_poi = 3; allocate(geom.face(205).poi(3)); geom.face(205).poi(1:3) = [ 102, 103, 105 ]
    geom.face(206).n_poi = 3; allocate(geom.face(206).poi(3)); geom.face(206).poi(1:3) = [ 103, 104, 105 ]
end subroutine Exam_Asym_Rod

! -----------------------------------------------------------------------------

! Example of Stickman
subroutine Exam_Asym_Stickman(prob, geom)
    type(ProbType), intent(inout) :: prob
    type(GeomType), intent(inout) :: geom

    character(10) :: char_sec, char_bp, char_start_bp

    write(unit=char_sec,      fmt = "(i10)"), prob.sel_sec
    write(unit=char_bp,       fmt = "(i10)"), prob.n_bp_edge
    write(unit=char_start_bp, fmt = "(i10)"), para_start_bp_ID

    prob.name_prob = "Stickman"
    prob.name_file = "Stickman"//&
        "_"//trim(adjustl(trim(char_sec)))//"cs"//&
        "_"//trim(adjustl(trim(char_bp)))//"bp"//&
        "_"//trim(para_vertex_design)

    ! Problem specified preset parameters
    if(para_vertex_design == "flat" .and. para_preset == "on") then
        para_junc_ang        = "max"    ! Junction gap modification for different arm angle
        para_const_edge_mesh = "off"    ! Constant edge length from polyhedra mesh
        para_unpaired_scaf   = "off"    ! Unpaired scaffold nucleotides
        para_n_base_tn       = 7
    end if

    ! Set geometric type and view (atom, cylinder size, move_x, move_y)
    call Mani_Set_View_Color(prob, [195, 153, 107], "xz")

    ! Allocate point and face structure
    geom.n_iniP = 96
    geom.n_face = 188

    allocate(geom.iniP(geom.n_iniP))
    allocate(geom.face(geom.n_face))

    ! Set point position vectors
    geom.iniP(  1).pos(1:3) = [ -16.42769d0, -5.47591d0, -18.33558d0 ]; geom.iniP(  2).pos(1:3) = [  -5.47590d0, -5.47591d0, -18.33558d0 ]
    geom.iniP(  3).pos(1:3) = [   5.47590d0, -5.47591d0, -18.33558d0 ]; geom.iniP(  4).pos(1:3) = [  16.42769d0, -5.47591d0, -18.33558d0 ]
    geom.iniP(  5).pos(1:3) = [ -16.42769d0, -5.47590d0,  -7.38379d0 ]; geom.iniP(  6).pos(1:3) = [  -5.47590d0, -5.47590d0,  -7.38379d0 ]
    geom.iniP(  7).pos(1:3) = [   5.47590d0, -5.47590d0,  -7.38379d0 ]; geom.iniP(  8).pos(1:3) = [  16.42769d0, -5.47590d0,  -7.38379d0 ]
    geom.iniP(  9).pos(1:3) = [ -16.42769d0, -5.47590d0,   3.56800d0 ]; geom.iniP( 10).pos(1:3) = [  -5.47590d0, -5.47590d0,   3.56800d0 ]
    geom.iniP( 11).pos(1:3) = [   5.47590d0, -5.47590d0,   3.56800d0 ]; geom.iniP( 12).pos(1:3) = [  16.42769d0, -5.47590d0,   3.56800d0 ]
    geom.iniP( 13).pos(1:3) = [ -16.42769d0, -5.47590d0,  14.51980d0 ]; geom.iniP( 14).pos(1:3) = [  -5.47590d0, -5.47590d0,  14.51980d0 ]
    geom.iniP( 15).pos(1:3) = [   5.47590d0, -5.47590d0,  14.51980d0 ]; geom.iniP( 16).pos(1:3) = [  16.42769d0, -5.47590d0,  14.51980d0 ]
    geom.iniP( 17).pos(1:3) = [ -16.42769d0, -5.47588d0,  25.47159d0 ]; geom.iniP( 18).pos(1:3) = [  -5.47590d0, -5.47588d0,  25.47159d0 ]
    geom.iniP( 19).pos(1:3) = [   5.47590d0, -5.47588d0,  25.47159d0 ]; geom.iniP( 20).pos(1:3) = [  16.42769d0, -5.47588d0,  25.47159d0 ]
    geom.iniP( 21).pos(1:3) = [ -16.42769d0,  5.47591d0,  25.47159d0 ]; geom.iniP( 22).pos(1:3) = [  -5.47590d0,  5.47591d0,  25.47159d0 ]
    geom.iniP( 23).pos(1:3) = [   5.47590d0,  5.47591d0,  25.47159d0 ]; geom.iniP( 24).pos(1:3) = [  16.42769d0,  5.47591d0,  25.47159d0 ]
    geom.iniP( 25).pos(1:3) = [ -16.42769d0,  5.47590d0,  14.51980d0 ]; geom.iniP( 26).pos(1:3) = [  -5.47590d0,  5.47590d0,  14.51980d0 ]
    geom.iniP( 27).pos(1:3) = [   5.47590d0,  5.47590d0,  14.51980d0 ]; geom.iniP( 28).pos(1:3) = [  16.42769d0,  5.47590d0,  14.51980d0 ]
    geom.iniP( 29).pos(1:3) = [ -16.42769d0,  5.47590d0,   3.56800d0 ]; geom.iniP( 30).pos(1:3) = [  -5.47590d0,  5.47590d0,   3.56800d0 ]
    geom.iniP( 31).pos(1:3) = [   5.47590d0,  5.47590d0,   3.56800d0 ]; geom.iniP( 32).pos(1:3) = [  16.42769d0,  5.47590d0,   3.56800d0 ]
    geom.iniP( 33).pos(1:3) = [ -16.42769d0,  5.47590d0,  -7.38379d0 ]; geom.iniP( 34).pos(1:3) = [  -5.47590d0,  5.47590d0,  -7.38379d0 ]
    geom.iniP( 35).pos(1:3) = [   5.47590d0,  5.47590d0,  -7.38379d0 ]; geom.iniP( 36).pos(1:3) = [  16.42769d0,  5.47590d0,  -7.38379d0 ]
    geom.iniP( 37).pos(1:3) = [ -16.42769d0,  5.47589d0, -18.33558d0 ]; geom.iniP( 38).pos(1:3) = [  -5.47590d0,  5.47589d0, -18.33558d0 ]
    geom.iniP( 39).pos(1:3) = [   5.47590d0,  5.47589d0, -18.33558d0 ]; geom.iniP( 40).pos(1:3) = [  16.42769d0,  5.47589d0, -18.33558d0 ]
    geom.iniP( 41).pos(1:3) = [ -18.32235d0,  5.47589d0, -28.80550d0 ]; geom.iniP( 42).pos(1:3) = [ -20.19511d0,  5.47589d0, -39.27541d0 ]
    geom.iniP( 43).pos(1:3) = [ -22.04596d0,  5.47588d0, -49.74533d0 ]; geom.iniP( 44).pos(1:3) = [  -7.38151d0,  5.47589d0, -29.44070d0 ]
    geom.iniP( 45).pos(1:3) = [  -9.31998d0,  5.47589d0, -40.54582d0 ]; geom.iniP( 46).pos(1:3) = [ -11.26940d0,  5.47588d0, -51.63999d0 ]
    geom.iniP( 47).pos(1:3) = [  -7.38151d0, -5.47591d0, -29.44070d0 ]; geom.iniP( 48).pos(1:3) = [  -9.31998d0, -5.47591d0, -40.54582d0 ]
    geom.iniP( 49).pos(1:3) = [ -11.26940d0, -5.47592d0, -51.63999d0 ]; geom.iniP( 50).pos(1:3) = [ -18.32235d0, -5.47591d0, -28.80550d0 ]
    geom.iniP( 51).pos(1:3) = [ -20.19511d0, -5.47591d0, -39.27541d0 ]; geom.iniP( 52).pos(1:3) = [ -22.04596d0, -5.47592d0, -49.74533d0 ]
    geom.iniP( 53).pos(1:3) = [   7.38151d0,  5.47589d0, -29.44070d0 ]; geom.iniP( 54).pos(1:3) = [   9.31998d0,  5.47589d0, -40.54582d0 ]
    geom.iniP( 55).pos(1:3) = [  11.26940d0,  5.47588d0, -51.63999d0 ]; geom.iniP( 56).pos(1:3) = [  18.32235d0,  5.47589d0, -28.80550d0 ]
    geom.iniP( 57).pos(1:3) = [  20.19511d0,  5.47589d0, -39.27541d0 ]; geom.iniP( 58).pos(1:3) = [  22.04596d0,  5.47588d0, -49.74533d0 ]
    geom.iniP( 59).pos(1:3) = [  18.32235d0, -5.47591d0, -28.80550d0 ]; geom.iniP( 60).pos(1:3) = [  20.19511d0, -5.47591d0, -39.27541d0 ]
    geom.iniP( 61).pos(1:3) = [  22.04596d0, -5.47592d0, -49.74533d0 ]; geom.iniP( 62).pos(1:3) = [   7.38151d0, -5.47591d0, -29.44070d0 ]
    geom.iniP( 63).pos(1:3) = [   9.31998d0, -5.47591d0, -40.54582d0 ]; geom.iniP( 64).pos(1:3) = [  11.26940d0, -5.47592d0, -51.63999d0 ]
    geom.iniP( 65).pos(1:3) = [  26.86475d0,  5.47590d0,  20.08331d0 ]; geom.iniP( 66).pos(1:3) = [  37.26895d0,  5.47591d0,  25.80014d0 ]
    geom.iniP( 67).pos(1:3) = [  47.61840d0,  5.47591d0,  31.68126d0 ]; geom.iniP( 68).pos(1:3) = [  26.86475d0, -5.47588d0,  20.08331d0 ]
    geom.iniP( 69).pos(1:3) = [  37.26895d0, -5.47588d0,  25.80014d0 ]; geom.iniP( 70).pos(1:3) = [  47.61840d0, -5.47588d0,  31.68126d0 ]
    geom.iniP( 71).pos(1:3) = [  24.95914d0,  5.47591d0,  30.85987d0 ]; geom.iniP( 72).pos(1:3) = [  33.52344d0,  5.47591d0,  36.09483d0 ]
    geom.iniP( 73).pos(1:3) = [  42.14250d0,  5.47591d0,  41.16551d0 ]; geom.iniP( 74).pos(1:3) = [  24.95914d0, -5.47588d0,  30.85987d0 ]
    geom.iniP( 75).pos(1:3) = [  33.52344d0, -5.47588d0,  36.09483d0 ]; geom.iniP( 76).pos(1:3) = [  42.14250d0, -5.47588d0,  41.16551d0 ]
    geom.iniP( 77).pos(1:3) = [ -24.95914d0,  5.47590d0,   9.13151d0 ]; geom.iniP( 78).pos(1:3) = [ -33.52344d0,  5.47590d0,   3.89655d0 ]
    geom.iniP( 79).pos(1:3) = [ -42.14250d0,  5.47590d0,  -1.17412d0 ]; geom.iniP( 80).pos(1:3) = [ -24.95914d0, -5.47590d0,   9.13151d0 ]
    geom.iniP( 81).pos(1:3) = [ -33.52344d0, -5.47590d0,   3.89656d0 ]; geom.iniP( 82).pos(1:3) = [ -42.14250d0, -5.47590d0,  -1.17412d0 ]
    geom.iniP( 83).pos(1:3) = [ -26.86475d0, -5.47590d0,  19.90808d0 ]; geom.iniP( 84).pos(1:3) = [ -37.26895d0, -5.47590d0,  14.19124d0 ]
    geom.iniP( 85).pos(1:3) = [ -47.61840d0, -5.47590d0,   8.31013d0 ]; geom.iniP( 86).pos(1:3) = [ -26.86475d0,  5.47590d0,  19.90808d0 ]
    geom.iniP( 87).pos(1:3) = [ -37.26895d0,  5.47590d0,  14.19124d0 ]; geom.iniP( 88).pos(1:3) = [ -47.61840d0,  5.47590d0,   8.31013d0 ]
    geom.iniP( 89).pos(1:3) = [  -6.57108d0, -6.57106d0,  36.42338d0 ]; geom.iniP( 90).pos(1:3) = [   6.57108d0, -6.57106d0,  36.42338d0 ]
    geom.iniP( 91).pos(1:3) = [   6.57108d0,  6.57109d0,  36.42338d0 ]; geom.iniP( 92).pos(1:3) = [  -6.57108d0,  6.57109d0,  36.42338d0 ]
    geom.iniP( 93).pos(1:3) = [  -5.25686d0, -5.25685d0,  47.37518d0 ]; geom.iniP( 94).pos(1:3) = [   5.25686d0, -5.25685d0,  47.37518d0 ]
    geom.iniP( 95).pos(1:3) = [   5.25686d0,  5.25687d0,  47.37518d0 ]; geom.iniP( 96).pos(1:3) = [  -5.25686d0,  5.25687d0,  47.37518d0 ]

    ! Set face connnectivity
    geom.face(  1).n_poi = 3; allocate(geom.face(  1).poi(3)); geom.face(  1).poi(1:3) = [  1,   2,   5 ]
    geom.face(  2).n_poi = 3; allocate(geom.face(  2).poi(3)); geom.face(  2).poi(1:3) = [  5,   2,   6 ]
    geom.face(  3).n_poi = 3; allocate(geom.face(  3).poi(3)); geom.face(  3).poi(1:3) = [  2,   3,   6 ]
    geom.face(  4).n_poi = 3; allocate(geom.face(  4).poi(3)); geom.face(  4).poi(1:3) = [  6,   3,   7 ]
    geom.face(  5).n_poi = 3; allocate(geom.face(  5).poi(3)); geom.face(  5).poi(1:3) = [  3,   4,   7 ]
    geom.face(  6).n_poi = 3; allocate(geom.face(  6).poi(3)); geom.face(  6).poi(1:3) = [  7,   4,   8 ]
    geom.face(  7).n_poi = 3; allocate(geom.face(  7).poi(3)); geom.face(  7).poi(1:3) = [  5,   6,   9 ]
    geom.face(  8).n_poi = 3; allocate(geom.face(  8).poi(3)); geom.face(  8).poi(1:3) = [  9,   6,  10 ]
    geom.face(  9).n_poi = 3; allocate(geom.face(  9).poi(3)); geom.face(  9).poi(1:3) = [  6,   7,  10 ]
    geom.face( 10).n_poi = 3; allocate(geom.face( 10).poi(3)); geom.face( 10).poi(1:3) = [ 10,   7,  11 ]
    geom.face( 11).n_poi = 3; allocate(geom.face( 11).poi(3)); geom.face( 11).poi(1:3) = [  7,   8,  11 ]
    geom.face( 12).n_poi = 3; allocate(geom.face( 12).poi(3)); geom.face( 12).poi(1:3) = [ 11,   8,  12 ]
    geom.face( 13).n_poi = 3; allocate(geom.face( 13).poi(3)); geom.face( 13).poi(1:3) = [  9,  10,  13 ]
    geom.face( 14).n_poi = 3; allocate(geom.face( 14).poi(3)); geom.face( 14).poi(1:3) = [ 13,  10,  14 ]
    geom.face( 15).n_poi = 3; allocate(geom.face( 15).poi(3)); geom.face( 15).poi(1:3) = [ 10,  11,  14 ]
    geom.face( 16).n_poi = 3; allocate(geom.face( 16).poi(3)); geom.face( 16).poi(1:3) = [ 14,  11,  15 ]
    geom.face( 17).n_poi = 3; allocate(geom.face( 17).poi(3)); geom.face( 17).poi(1:3) = [ 11,  12,  15 ]
    geom.face( 18).n_poi = 3; allocate(geom.face( 18).poi(3)); geom.face( 18).poi(1:3) = [ 15,  12,  16 ]
    geom.face( 19).n_poi = 3; allocate(geom.face( 19).poi(3)); geom.face( 19).poi(1:3) = [ 13,  14,  17 ]
    geom.face( 20).n_poi = 3; allocate(geom.face( 20).poi(3)); geom.face( 20).poi(1:3) = [ 17,  14,  18 ]
    geom.face( 21).n_poi = 3; allocate(geom.face( 21).poi(3)); geom.face( 21).poi(1:3) = [ 14,  15,  18 ]
    geom.face( 22).n_poi = 3; allocate(geom.face( 22).poi(3)); geom.face( 22).poi(1:3) = [ 18,  15,  19 ]
    geom.face( 23).n_poi = 3; allocate(geom.face( 23).poi(3)); geom.face( 23).poi(1:3) = [ 15,  16,  19 ]
    geom.face( 24).n_poi = 3; allocate(geom.face( 24).poi(3)); geom.face( 24).poi(1:3) = [ 19,  16,  20 ]
    geom.face( 25).n_poi = 3; allocate(geom.face( 25).poi(3)); geom.face( 25).poi(1:3) = [ 17,  18,  21 ]
    geom.face( 26).n_poi = 3; allocate(geom.face( 26).poi(3)); geom.face( 26).poi(1:3) = [ 21,  18,  22 ]
    geom.face( 27).n_poi = 3; allocate(geom.face( 27).poi(3)); geom.face( 27).poi(1:3) = [ 93,  94,  96 ]
    geom.face( 28).n_poi = 3; allocate(geom.face( 28).poi(3)); geom.face( 28).poi(1:3) = [ 96,  94,  95 ]
    geom.face( 29).n_poi = 3; allocate(geom.face( 29).poi(3)); geom.face( 29).poi(1:3) = [ 19,  20,  23 ]
    geom.face( 30).n_poi = 3; allocate(geom.face( 30).poi(3)); geom.face( 30).poi(1:3) = [ 23,  20,  24 ]
    geom.face( 31).n_poi = 3; allocate(geom.face( 31).poi(3)); geom.face( 31).poi(1:3) = [ 21,  22,  25 ]
    geom.face( 32).n_poi = 3; allocate(geom.face( 32).poi(3)); geom.face( 32).poi(1:3) = [ 25,  22,  26 ]
    geom.face( 33).n_poi = 3; allocate(geom.face( 33).poi(3)); geom.face( 33).poi(1:3) = [ 22,  23,  26 ]
    geom.face( 34).n_poi = 3; allocate(geom.face( 34).poi(3)); geom.face( 34).poi(1:3) = [ 26,  23,  27 ]
    geom.face( 35).n_poi = 3; allocate(geom.face( 35).poi(3)); geom.face( 35).poi(1:3) = [ 23,  24,  27 ]
    geom.face( 36).n_poi = 3; allocate(geom.face( 36).poi(3)); geom.face( 36).poi(1:3) = [ 27,  24,  28 ]
    geom.face( 37).n_poi = 3; allocate(geom.face( 37).poi(3)); geom.face( 37).poi(1:3) = [ 25,  26,  29 ]
    geom.face( 38).n_poi = 3; allocate(geom.face( 38).poi(3)); geom.face( 38).poi(1:3) = [ 29,  26,  30 ]
    geom.face( 39).n_poi = 3; allocate(geom.face( 39).poi(3)); geom.face( 39).poi(1:3) = [ 26,  27,  30 ]
    geom.face( 40).n_poi = 3; allocate(geom.face( 40).poi(3)); geom.face( 40).poi(1:3) = [ 30,  27,  31 ]
    geom.face( 41).n_poi = 3; allocate(geom.face( 41).poi(3)); geom.face( 41).poi(1:3) = [ 27,  28,  31 ]
    geom.face( 42).n_poi = 3; allocate(geom.face( 42).poi(3)); geom.face( 42).poi(1:3) = [ 31,  28,  32 ]
    geom.face( 43).n_poi = 3; allocate(geom.face( 43).poi(3)); geom.face( 43).poi(1:3) = [ 29,  30,  33 ]
    geom.face( 44).n_poi = 3; allocate(geom.face( 44).poi(3)); geom.face( 44).poi(1:3) = [ 33,  30,  34 ]
    geom.face( 45).n_poi = 3; allocate(geom.face( 45).poi(3)); geom.face( 45).poi(1:3) = [ 30,  31,  34 ]
    geom.face( 46).n_poi = 3; allocate(geom.face( 46).poi(3)); geom.face( 46).poi(1:3) = [ 34,  31,  35 ]
    geom.face( 47).n_poi = 3; allocate(geom.face( 47).poi(3)); geom.face( 47).poi(1:3) = [ 31,  32,  35 ]
    geom.face( 48).n_poi = 3; allocate(geom.face( 48).poi(3)); geom.face( 48).poi(1:3) = [ 35,  32,  36 ]
    geom.face( 49).n_poi = 3; allocate(geom.face( 49).poi(3)); geom.face( 49).poi(1:3) = [ 33,  34,  37 ]
    geom.face( 50).n_poi = 3; allocate(geom.face( 50).poi(3)); geom.face( 50).poi(1:3) = [ 37,  34,  38 ]
    geom.face( 51).n_poi = 3; allocate(geom.face( 51).poi(3)); geom.face( 51).poi(1:3) = [ 34,  35,  38 ]
    geom.face( 52).n_poi = 3; allocate(geom.face( 52).poi(3)); geom.face( 52).poi(1:3) = [ 38,  35,  39 ]
    geom.face( 53).n_poi = 3; allocate(geom.face( 53).poi(3)); geom.face( 53).poi(1:3) = [ 35,  36,  39 ]
    geom.face( 54).n_poi = 3; allocate(geom.face( 54).poi(3)); geom.face( 54).poi(1:3) = [ 39,  36,  40 ]
    geom.face( 55).n_poi = 3; allocate(geom.face( 55).poi(3)); geom.face( 55).poi(1:3) = [ 43,  46,  52 ]
    geom.face( 56).n_poi = 3; allocate(geom.face( 56).poi(3)); geom.face( 56).poi(1:3) = [ 52,  46,  49 ]
    geom.face( 57).n_poi = 3; allocate(geom.face( 57).poi(3)); geom.face( 57).poi(1:3) = [ 38,  39,   2 ]
    geom.face( 58).n_poi = 3; allocate(geom.face( 58).poi(3)); geom.face( 58).poi(1:3) = [  2,  39,   3 ]
    geom.face( 59).n_poi = 3; allocate(geom.face( 59).poi(3)); geom.face( 59).poi(1:3) = [ 55,  58,  64 ]
    geom.face( 60).n_poi = 3; allocate(geom.face( 60).poi(3)); geom.face( 60).poi(1:3) = [ 64,  58,  61 ]
    geom.face( 61).n_poi = 3; allocate(geom.face( 61).poi(3)); geom.face( 61).poi(1:3) = [  4,  40,   8 ]
    geom.face( 62).n_poi = 3; allocate(geom.face( 62).poi(3)); geom.face( 62).poi(1:3) = [  8,  40,  36 ]
    geom.face( 63).n_poi = 3; allocate(geom.face( 63).poi(3)); geom.face( 63).poi(1:3) = [  8,  36,  12 ]
    geom.face( 64).n_poi = 3; allocate(geom.face( 64).poi(3)); geom.face( 64).poi(1:3) = [ 12,  36,  32 ]
    geom.face( 65).n_poi = 3; allocate(geom.face( 65).poi(3)); geom.face( 65).poi(1:3) = [ 12,  32,  16 ]
    geom.face( 66).n_poi = 3; allocate(geom.face( 66).poi(3)); geom.face( 66).poi(1:3) = [ 16,  32,  28 ]
    geom.face( 67).n_poi = 3; allocate(geom.face( 67).poi(3)); geom.face( 67).poi(1:3) = [ 70,  67,  76 ]
    geom.face( 68).n_poi = 3; allocate(geom.face( 68).poi(3)); geom.face( 68).poi(1:3) = [ 76,  67,  73 ]
    geom.face( 69).n_poi = 3; allocate(geom.face( 69).poi(3)); geom.face( 69).poi(1:3) = [ 37,   1,  33 ]
    geom.face( 70).n_poi = 3; allocate(geom.face( 70).poi(3)); geom.face( 70).poi(1:3) = [ 33,   1,   5 ]
    geom.face( 71).n_poi = 3; allocate(geom.face( 71).poi(3)); geom.face( 71).poi(1:3) = [ 33,   5,  29 ]
    geom.face( 72).n_poi = 3; allocate(geom.face( 72).poi(3)); geom.face( 72).poi(1:3) = [ 29,   5,   9 ]
    geom.face( 73).n_poi = 3; allocate(geom.face( 73).poi(3)); geom.face( 73).poi(1:3) = [ 29,   9,  25 ]
    geom.face( 74).n_poi = 3; allocate(geom.face( 74).poi(3)); geom.face( 74).poi(1:3) = [ 25,   9,  13 ]
    geom.face( 75).n_poi = 3; allocate(geom.face( 75).poi(3)); geom.face( 75).poi(1:3) = [ 79,  82,  88 ]
    geom.face( 76).n_poi = 3; allocate(geom.face( 76).poi(3)); geom.face( 76).poi(1:3) = [ 88,  82,  85 ]
    geom.face( 77).n_poi = 3; allocate(geom.face( 77).poi(3)); geom.face( 77).poi(1:3) = [ 38,  44,  37 ]
    geom.face( 78).n_poi = 3; allocate(geom.face( 78).poi(3)); geom.face( 78).poi(1:3) = [ 37,  44,  41 ]
    geom.face( 79).n_poi = 3; allocate(geom.face( 79).poi(3)); geom.face( 79).poi(1:3) = [ 44,  45,  41 ]
    geom.face( 80).n_poi = 3; allocate(geom.face( 80).poi(3)); geom.face( 80).poi(1:3) = [ 41,  45,  42 ]
    geom.face( 81).n_poi = 3; allocate(geom.face( 81).poi(3)); geom.face( 81).poi(1:3) = [ 45,  46,  42 ]
    geom.face( 82).n_poi = 3; allocate(geom.face( 82).poi(3)); geom.face( 82).poi(1:3) = [ 42,  46,  43 ]
    geom.face( 83).n_poi = 3; allocate(geom.face( 83).poi(3)); geom.face( 83).poi(1:3) = [ 38,   2,  44 ]
    geom.face( 84).n_poi = 3; allocate(geom.face( 84).poi(3)); geom.face( 84).poi(1:3) = [ 44,   2,  47 ]
    geom.face( 85).n_poi = 3; allocate(geom.face( 85).poi(3)); geom.face( 85).poi(1:3) = [ 44,  47,  45 ]
    geom.face( 86).n_poi = 3; allocate(geom.face( 86).poi(3)); geom.face( 86).poi(1:3) = [ 45,  47,  48 ]
    geom.face( 87).n_poi = 3; allocate(geom.face( 87).poi(3)); geom.face( 87).poi(1:3) = [ 45,  48,  46 ]
    geom.face( 88).n_poi = 3; allocate(geom.face( 88).poi(3)); geom.face( 88).poi(1:3) = [ 46,  48,  49 ]
    geom.face( 89).n_poi = 3; allocate(geom.face( 89).poi(3)); geom.face( 89).poi(1:3) = [  2,   1,  47 ]
    geom.face( 90).n_poi = 3; allocate(geom.face( 90).poi(3)); geom.face( 90).poi(1:3) = [ 47,   1,  50 ]
    geom.face( 91).n_poi = 3; allocate(geom.face( 91).poi(3)); geom.face( 91).poi(1:3) = [ 47,  50,  48 ]
    geom.face( 92).n_poi = 3; allocate(geom.face( 92).poi(3)); geom.face( 92).poi(1:3) = [ 48,  50,  51 ]
    geom.face( 93).n_poi = 3; allocate(geom.face( 93).poi(3)); geom.face( 93).poi(1:3) = [ 48,  51,  49 ]
    geom.face( 94).n_poi = 3; allocate(geom.face( 94).poi(3)); geom.face( 94).poi(1:3) = [ 49,  51,  52 ]
    geom.face( 95).n_poi = 3; allocate(geom.face( 95).poi(3)); geom.face( 95).poi(1:3) = [  1,  37,  50 ]
    geom.face( 96).n_poi = 3; allocate(geom.face( 96).poi(3)); geom.face( 96).poi(1:3) = [ 50,  37,  41 ]
    geom.face( 97).n_poi = 3; allocate(geom.face( 97).poi(3)); geom.face( 97).poi(1:3) = [ 50,  41,  51 ]
    geom.face( 98).n_poi = 3; allocate(geom.face( 98).poi(3)); geom.face( 98).poi(1:3) = [ 51,  41,  42 ]
    geom.face( 99).n_poi = 3; allocate(geom.face( 99).poi(3)); geom.face( 99).poi(1:3) = [ 51,  42,  52 ]
    geom.face(100).n_poi = 3; allocate(geom.face(100).poi(3)); geom.face(100).poi(1:3) = [ 52,  42,  43 ]
    geom.face(101).n_poi = 3; allocate(geom.face(101).poi(3)); geom.face(101).poi(1:3) = [ 39,  40,  53 ]
    geom.face(102).n_poi = 3; allocate(geom.face(102).poi(3)); geom.face(102).poi(1:3) = [ 53,  40,  56 ]
    geom.face(103).n_poi = 3; allocate(geom.face(103).poi(3)); geom.face(103).poi(1:3) = [ 53,  56,  54 ]
    geom.face(104).n_poi = 3; allocate(geom.face(104).poi(3)); geom.face(104).poi(1:3) = [ 54,  56,  57 ]
    geom.face(105).n_poi = 3; allocate(geom.face(105).poi(3)); geom.face(105).poi(1:3) = [ 54,  57,  55 ]
    geom.face(106).n_poi = 3; allocate(geom.face(106).poi(3)); geom.face(106).poi(1:3) = [ 55,  57,  58 ]
    geom.face(107).n_poi = 3; allocate(geom.face(107).poi(3)); geom.face(107).poi(1:3) = [ 40,   4,  56 ]
    geom.face(108).n_poi = 3; allocate(geom.face(108).poi(3)); geom.face(108).poi(1:3) = [ 56,   4,  59 ]
    geom.face(109).n_poi = 3; allocate(geom.face(109).poi(3)); geom.face(109).poi(1:3) = [ 56,  59,  57 ]
    geom.face(110).n_poi = 3; allocate(geom.face(110).poi(3)); geom.face(110).poi(1:3) = [ 57,  59,  60 ]
    geom.face(111).n_poi = 3; allocate(geom.face(111).poi(3)); geom.face(111).poi(1:3) = [ 57,  60,  58 ]
    geom.face(112).n_poi = 3; allocate(geom.face(112).poi(3)); geom.face(112).poi(1:3) = [ 58,  60,  61 ]
    geom.face(113).n_poi = 3; allocate(geom.face(113).poi(3)); geom.face(113).poi(1:3) = [  3,  62,   4 ]
    geom.face(114).n_poi = 3; allocate(geom.face(114).poi(3)); geom.face(114).poi(1:3) = [  4,  62,  59 ]
    geom.face(115).n_poi = 3; allocate(geom.face(115).poi(3)); geom.face(115).poi(1:3) = [ 62,  63,  59 ]
    geom.face(116).n_poi = 3; allocate(geom.face(116).poi(3)); geom.face(116).poi(1:3) = [ 59,  63,  60 ]
    geom.face(117).n_poi = 3; allocate(geom.face(117).poi(3)); geom.face(117).poi(1:3) = [ 63,  64,  60 ]
    geom.face(118).n_poi = 3; allocate(geom.face(118).poi(3)); geom.face(118).poi(1:3) = [ 60,  64,  61 ]
    geom.face(119).n_poi = 3; allocate(geom.face(119).poi(3)); geom.face(119).poi(1:3) = [  3,  39,  62 ]
    geom.face(120).n_poi = 3; allocate(geom.face(120).poi(3)); geom.face(120).poi(1:3) = [ 62,  39,  53 ]
    geom.face(121).n_poi = 3; allocate(geom.face(121).poi(3)); geom.face(121).poi(1:3) = [ 62,  53,  63 ]
    geom.face(122).n_poi = 3; allocate(geom.face(122).poi(3)); geom.face(122).poi(1:3) = [ 63,  53,  54 ]
    geom.face(123).n_poi = 3; allocate(geom.face(123).poi(3)); geom.face(123).poi(1:3) = [ 63,  54,  64 ]
    geom.face(124).n_poi = 3; allocate(geom.face(124).poi(3)); geom.face(124).poi(1:3) = [ 64,  54,  55 ]
    geom.face(125).n_poi = 3; allocate(geom.face(125).poi(3)); geom.face(125).poi(1:3) = [ 16,  28,  68 ]
    geom.face(126).n_poi = 3; allocate(geom.face(126).poi(3)); geom.face(126).poi(1:3) = [ 68,  28,  65 ]
    geom.face(127).n_poi = 3; allocate(geom.face(127).poi(3)); geom.face(127).poi(1:3) = [ 68,  65,  69 ]
    geom.face(128).n_poi = 3; allocate(geom.face(128).poi(3)); geom.face(128).poi(1:3) = [ 69,  65,  66 ]
    geom.face(129).n_poi = 3; allocate(geom.face(129).poi(3)); geom.face(129).poi(1:3) = [ 69,  66,  70 ]
    geom.face(130).n_poi = 3; allocate(geom.face(130).poi(3)); geom.face(130).poi(1:3) = [ 70,  66,  67 ]
    geom.face(131).n_poi = 3; allocate(geom.face(131).poi(3)); geom.face(131).poi(1:3) = [ 28,  24,  65 ]
    geom.face(132).n_poi = 3; allocate(geom.face(132).poi(3)); geom.face(132).poi(1:3) = [ 65,  24,  71 ]
    geom.face(133).n_poi = 3; allocate(geom.face(133).poi(3)); geom.face(133).poi(1:3) = [ 65,  71,  66 ]
    geom.face(134).n_poi = 3; allocate(geom.face(134).poi(3)); geom.face(134).poi(1:3) = [ 66,  71,  72 ]
    geom.face(135).n_poi = 3; allocate(geom.face(135).poi(3)); geom.face(135).poi(1:3) = [ 66,  72,  67 ]
    geom.face(136).n_poi = 3; allocate(geom.face(136).poi(3)); geom.face(136).poi(1:3) = [ 67,  72,  73 ]
    geom.face(137).n_poi = 3; allocate(geom.face(137).poi(3)); geom.face(137).poi(1:3) = [ 24,  20,  71 ]
    geom.face(138).n_poi = 3; allocate(geom.face(138).poi(3)); geom.face(138).poi(1:3) = [ 71,  20,  74 ]
    geom.face(139).n_poi = 3; allocate(geom.face(139).poi(3)); geom.face(139).poi(1:3) = [ 71,  74,  72 ]
    geom.face(140).n_poi = 3; allocate(geom.face(140).poi(3)); geom.face(140).poi(1:3) = [ 72,  74,  75 ]
    geom.face(141).n_poi = 3; allocate(geom.face(141).poi(3)); geom.face(141).poi(1:3) = [ 72,  75,  73 ]
    geom.face(142).n_poi = 3; allocate(geom.face(142).poi(3)); geom.face(142).poi(1:3) = [ 73,  75,  76 ]
    geom.face(143).n_poi = 3; allocate(geom.face(143).poi(3)); geom.face(143).poi(1:3) = [ 16,  68,  20 ]
    geom.face(144).n_poi = 3; allocate(geom.face(144).poi(3)); geom.face(144).poi(1:3) = [ 20,  68,  74 ]
    geom.face(145).n_poi = 3; allocate(geom.face(145).poi(3)); geom.face(145).poi(1:3) = [ 68,  69,  74 ]
    geom.face(146).n_poi = 3; allocate(geom.face(146).poi(3)); geom.face(146).poi(1:3) = [ 74,  69,  75 ]
    geom.face(147).n_poi = 3; allocate(geom.face(147).poi(3)); geom.face(147).poi(1:3) = [ 69,  70,  75 ]
    geom.face(148).n_poi = 3; allocate(geom.face(148).poi(3)); geom.face(148).poi(1:3) = [ 75,  70,  76 ]
    geom.face(149).n_poi = 3; allocate(geom.face(149).poi(3)); geom.face(149).poi(1:3) = [ 25,  13,  77 ]
    geom.face(150).n_poi = 3; allocate(geom.face(150).poi(3)); geom.face(150).poi(1:3) = [ 77,  13,  80 ]
    geom.face(151).n_poi = 3; allocate(geom.face(151).poi(3)); geom.face(151).poi(1:3) = [ 77,  80,  78 ]
    geom.face(152).n_poi = 3; allocate(geom.face(152).poi(3)); geom.face(152).poi(1:3) = [ 78,  80,  81 ]
    geom.face(153).n_poi = 3; allocate(geom.face(153).poi(3)); geom.face(153).poi(1:3) = [ 78,  81,  79 ]
    geom.face(154).n_poi = 3; allocate(geom.face(154).poi(3)); geom.face(154).poi(1:3) = [ 79,  81,  82 ]
    geom.face(155).n_poi = 3; allocate(geom.face(155).poi(3)); geom.face(155).poi(1:3) = [ 17,  83,  13 ]
    geom.face(156).n_poi = 3; allocate(geom.face(156).poi(3)); geom.face(156).poi(1:3) = [ 13,  83,  80 ]
    geom.face(157).n_poi = 3; allocate(geom.face(157).poi(3)); geom.face(157).poi(1:3) = [ 83,  84,  80 ]
    geom.face(158).n_poi = 3; allocate(geom.face(158).poi(3)); geom.face(158).poi(1:3) = [ 80,  84,  81 ]
    geom.face(159).n_poi = 3; allocate(geom.face(159).poi(3)); geom.face(159).poi(1:3) = [ 84,  85,  81 ]
    geom.face(160).n_poi = 3; allocate(geom.face(160).poi(3)); geom.face(160).poi(1:3) = [ 81,  85,  82 ]
    geom.face(161).n_poi = 3; allocate(geom.face(161).poi(3)); geom.face(161).poi(1:3) = [ 17,  21,  83 ]
    geom.face(162).n_poi = 3; allocate(geom.face(162).poi(3)); geom.face(162).poi(1:3) = [ 83,  21,  86 ]
    geom.face(163).n_poi = 3; allocate(geom.face(163).poi(3)); geom.face(163).poi(1:3) = [ 83,  86,  84 ]
    geom.face(164).n_poi = 3; allocate(geom.face(164).poi(3)); geom.face(164).poi(1:3) = [ 84,  86,  87 ]
    geom.face(165).n_poi = 3; allocate(geom.face(165).poi(3)); geom.face(165).poi(1:3) = [ 84,  87,  85 ]
    geom.face(166).n_poi = 3; allocate(geom.face(166).poi(3)); geom.face(166).poi(1:3) = [ 85,  87,  88 ]
    geom.face(167).n_poi = 3; allocate(geom.face(167).poi(3)); geom.face(167).poi(1:3) = [ 21,  25,  86 ]
    geom.face(168).n_poi = 3; allocate(geom.face(168).poi(3)); geom.face(168).poi(1:3) = [ 86,  25,  77 ]
    geom.face(169).n_poi = 3; allocate(geom.face(169).poi(3)); geom.face(169).poi(1:3) = [ 86,  77,  87 ]
    geom.face(170).n_poi = 3; allocate(geom.face(170).poi(3)); geom.face(170).poi(1:3) = [ 87,  77,  78 ]
    geom.face(171).n_poi = 3; allocate(geom.face(171).poi(3)); geom.face(171).poi(1:3) = [ 87,  78,  88 ]
    geom.face(172).n_poi = 3; allocate(geom.face(172).poi(3)); geom.face(172).poi(1:3) = [ 88,  78,  79 ]
    geom.face(173).n_poi = 3; allocate(geom.face(173).poi(3)); geom.face(173).poi(1:3) = [ 18,  19,  89 ]
    geom.face(174).n_poi = 3; allocate(geom.face(174).poi(3)); geom.face(174).poi(1:3) = [ 89,  19,  90 ]
    geom.face(175).n_poi = 3; allocate(geom.face(175).poi(3)); geom.face(175).poi(1:3) = [ 19,  23,  90 ]
    geom.face(176).n_poi = 3; allocate(geom.face(176).poi(3)); geom.face(176).poi(1:3) = [ 90,  23,  91 ]
    geom.face(177).n_poi = 3; allocate(geom.face(177).poi(3)); geom.face(177).poi(1:3) = [ 23,  22,  91 ]
    geom.face(178).n_poi = 3; allocate(geom.face(178).poi(3)); geom.face(178).poi(1:3) = [ 91,  22,  92 ]
    geom.face(179).n_poi = 3; allocate(geom.face(179).poi(3)); geom.face(179).poi(1:3) = [ 22,  18,  92 ]
    geom.face(180).n_poi = 3; allocate(geom.face(180).poi(3)); geom.face(180).poi(1:3) = [ 92,  18,  89 ]
    geom.face(181).n_poi = 3; allocate(geom.face(181).poi(3)); geom.face(181).poi(1:3) = [ 89,  90,  93 ]
    geom.face(182).n_poi = 3; allocate(geom.face(182).poi(3)); geom.face(182).poi(1:3) = [ 93,  90,  94 ]
    geom.face(183).n_poi = 3; allocate(geom.face(183).poi(3)); geom.face(183).poi(1:3) = [ 90,  91,  94 ]
    geom.face(184).n_poi = 3; allocate(geom.face(184).poi(3)); geom.face(184).poi(1:3) = [ 94,  91,  95 ]
    geom.face(185).n_poi = 3; allocate(geom.face(185).poi(3)); geom.face(185).poi(1:3) = [ 91,  92,  95 ]
    geom.face(186).n_poi = 3; allocate(geom.face(186).poi(3)); geom.face(186).poi(1:3) = [ 95,  92,  96 ]
    geom.face(187).n_poi = 3; allocate(geom.face(187).poi(3)); geom.face(187).poi(1:3) = [ 92,  89,  96 ]
    geom.face(188).n_poi = 3; allocate(geom.face(188).poi(3)); geom.face(188).poi(1:3) = [ 96,  89,  93 ]
end subroutine Exam_Asym_Stickman

! -----------------------------------------------------------------------------

! Example of Bottle
subroutine Exam_Asym_Bottle(prob, geom)
    type(ProbType), intent(inout) :: prob
    type(GeomType), intent(inout) :: geom

    character(10) :: char_sec, char_bp, char_start_bp

    write(unit=char_sec,      fmt = "(i10)"), prob.sel_sec
    write(unit=char_bp,       fmt = "(i10)"), prob.n_bp_edge
    write(unit=char_start_bp, fmt = "(i10)"), para_start_bp_ID

    prob.name_prob = "Bottle"
    prob.name_file = "Bottle"//&
        "_"//trim(adjustl(trim(char_sec)))//"cs"//&
        "_"//trim(adjustl(trim(char_bp)))//"bp"//&
        "_"//trim(para_vertex_design)

    ! Problem specified preset parameters
    if(para_vertex_design == "flat" .and. para_preset == "on") then
        para_junc_ang        = "max"    ! Junction gap modification for different arm angle
        para_const_edge_mesh = "off"    ! Constant edge length from polyhedra mesh
        para_unpaired_scaf   = "off"    ! Unpaired scaffold nucleotides
        para_n_base_tn       = 7
    end if

    ! Set geometric type and view (atom, cylinder size, move_x, move_y)
    call Mani_Set_View_Color(prob, [195, 153, 107], "xy")

    ! Allocate point and face structure
    geom.n_iniP = 68
    geom.n_face = 132

    allocate(geom.iniP(geom.n_iniP))
    allocate(geom.face(geom.n_face))

    ! Set point position vectors
    geom.iniP( 1).pos(1:3) = [  10.90759d0, -60.07786d0, -18.51369d0 ]; geom.iniP( 2).pos(1:3) = [ -10.88895d0, -60.07786d0, -18.51369d0 ]
    geom.iniP( 3).pos(1:3) = [ -21.78719d0, -60.07786d0,  -0.00658d0 ]; geom.iniP( 4).pos(1:3) = [ -10.88895d0, -60.07786d0,  18.50054d0 ]
    geom.iniP( 5).pos(1:3) = [  10.90759d0, -60.07786d0,  18.50054d0 ]; geom.iniP( 6).pos(1:3) = [  21.80583d0, -60.07786d0,  -0.00658d0 ]
    geom.iniP( 7).pos(1:3) = [  10.12188d0, -48.49314d0, -17.14739d0 ]; geom.iniP( 8).pos(1:3) = [ -10.10325d0, -48.49314d0, -17.14739d0 ]
    geom.iniP( 9).pos(1:3) = [ -20.19047d0, -48.49314d0,  -0.00658d0 ]; geom.iniP(10).pos(1:3) = [ -10.10325d0, -48.49314d0,  17.13424d0 ]
    geom.iniP(11).pos(1:3) = [  10.12188d0, -48.49314d0,  17.13424d0 ]; geom.iniP(12).pos(1:3) = [  20.20911d0, -48.49314d0,  -0.00658d0 ]
    geom.iniP(13).pos(1:3) = [   8.42379d0, -35.83683d0, -14.29060d0 ]; geom.iniP(14).pos(1:3) = [  -8.40516d0, -35.83683d0, -14.29060d0 ]
    geom.iniP(15).pos(1:3) = [ -16.81963d0, -35.83683d0,  -0.00658d0 ]; geom.iniP(16).pos(1:3) = [  -8.40516d0, -35.83683d0,  14.27744d0 ]
    geom.iniP(17).pos(1:3) = [   8.42379d0, -35.83683d0,  14.27744d0 ]; geom.iniP(18).pos(1:3) = [  16.83827d0, -35.83683d0,  -0.00658d0 ]
    geom.iniP(19).pos(1:3) = [   9.74173d0, -22.77505d0, -16.52633d0 ]; geom.iniP(20).pos(1:3) = [  -9.72309d0, -22.77505d0, -16.52633d0 ]
    geom.iniP(21).pos(1:3) = [ -19.43014d0, -22.77505d0,  -0.00658d0 ]; geom.iniP(22).pos(1:3) = [  -9.72309d0, -22.77505d0,  16.51318d0 ]
    geom.iniP(23).pos(1:3) = [   9.74173d0, -22.77505d0,  16.51318d0 ]; geom.iniP(24).pos(1:3) = [  19.44877d0, -22.77505d0,  -0.00658d0 ]
    geom.iniP(25).pos(1:3) = [  10.57809d0,  -9.16300d0, -17.94233d0 ]; geom.iniP(26).pos(1:3) = [ -10.55945d0,  -9.16300d0, -17.94233d0 ]
    geom.iniP(27).pos(1:3) = [ -21.10288d0,  -9.16300d0,  -0.00658d0 ]; geom.iniP(28).pos(1:3) = [ -10.55945d0,  -9.16300d0,  17.92918d0 ]
    geom.iniP(29).pos(1:3) = [  10.57809d0,  -9.16300d0,  17.92918d0 ]; geom.iniP(30).pos(1:3) = [  21.12152d0,  -9.16300d0,  -0.00658d0 ]
    geom.iniP(31).pos(1:3) = [  10.78085d0,   2.42172d0, -18.38947d0 ]; geom.iniP(32).pos(1:3) = [ -10.96498d0,   2.42172d0, -18.38947d0 ]
    geom.iniP(33).pos(1:3) = [ -21.83790d0,   2.42172d0,   0.06795d0 ]; geom.iniP(34).pos(1:3) = [ -10.96498d0,   2.42172d0,  18.52539d0 ]
    geom.iniP(35).pos(1:3) = [  10.78085d0,   2.42172d0,  18.52539d0 ]; geom.iniP(36).pos(1:3) = [  21.65378d0,   2.42172d0,   0.06795d0 ]
    geom.iniP(37).pos(1:3) = [  10.37533d0,  13.45617d0, -17.59453d0 ]; geom.iniP(38).pos(1:3) = [ -10.35669d0,  13.45617d0, -17.59453d0 ]
    geom.iniP(39).pos(1:3) = [ -20.72273d0,  13.45617d0,  -0.00658d0 ]; geom.iniP(40).pos(1:3) = [ -10.35669d0,  13.45617d0,  17.58138d0 ]
    geom.iniP(41).pos(1:3) = [  10.37533d0,  13.45617d0,  17.58138d0 ]; geom.iniP(42).pos(1:3) = [  20.71602d0,  13.45617d0,  -0.00658d0 ]
    geom.iniP(43).pos(1:3) = [   8.17035d0,  25.59116d0, -13.84343d0 ]; geom.iniP(44).pos(1:3) = [  -8.15171d0,  25.59116d0, -13.84343d0 ]
    geom.iniP(45).pos(1:3) = [ -16.28737d0,  25.59116d0,  -0.00658d0 ]; geom.iniP(46).pos(1:3) = [  -8.15171d0,  25.59116d0,  13.83027d0 ]
    geom.iniP(47).pos(1:3) = [   8.17035d0,  25.59116d0,  13.83027d0 ]; geom.iniP(48).pos(1:3) = [  16.30601d0,  25.59116d0,  -0.00658d0 ]
    geom.iniP(49).pos(1:3) = [   5.07827d0,  34.59828d0,  -8.62665d0 ]; geom.iniP(50).pos(1:3) = [  -5.05964d0,  34.59828d0,  -8.62665d0 ]
    geom.iniP(51).pos(1:3) = [ -10.12859d0,  34.59828d0,  -0.00658d0 ]; geom.iniP(52).pos(1:3) = [  -5.05964d0,  34.59828d0,   8.61350d0 ]
    geom.iniP(53).pos(1:3) = [   5.07827d0,  34.59828d0,   8.61350d0 ]; geom.iniP(54).pos(1:3) = [  10.14722d0,  34.59828d0,  -0.00658d0 ]
    geom.iniP(55).pos(1:3) = [   5.43311d0,  45.22727d0,  -9.19804d0 ]; geom.iniP(56).pos(1:3) = [  -5.41448d0,  45.22727d0,  -9.19804d0 ]
    geom.iniP(57).pos(1:3) = [ -10.81290d0,  45.22727d0,  -0.00658d0 ]; geom.iniP(58).pos(1:3) = [  -5.41448d0,  45.22727d0,   9.18489d0 ]
    geom.iniP(59).pos(1:3) = [   5.43311d0,  45.22727d0,   9.18489d0 ]; geom.iniP(60).pos(1:3) = [  10.83153d0,  45.22727d0,  -0.00658d0 ]
    geom.iniP(61).pos(1:3) = [   5.43311d0,  55.76937d0,  -9.19804d0 ]; geom.iniP(62).pos(1:3) = [  -5.41448d0,  55.76937d0,  -9.19804d0 ]
    geom.iniP(63).pos(1:3) = [ -10.81290d0,  55.76937d0,  -0.00658d0 ]; geom.iniP(64).pos(1:3) = [  -5.41448d0,  55.76937d0,   9.18489d0 ]
    geom.iniP(65).pos(1:3) = [   5.43311d0,  55.76937d0,   9.18489d0 ]; geom.iniP(66).pos(1:3) = [  10.83153d0,  55.76937d0,  -0.00658d0 ]
    geom.iniP(67).pos(1:3) = [   0.00932d0, -60.07786d0,  -0.00658d0 ]; geom.iniP(68).pos(1:3) = [   0.00932d0,  55.76937d0,  -0.00658d0 ]    

    ! Set face connnectivity
    geom.face(  1).n_poi = 3; allocate(geom.face(  1).poi(3)); geom.face(  1).poi(1:3) = [  1,  2,  7 ]
    geom.face(  2).n_poi = 3; allocate(geom.face(  2).poi(3)); geom.face(  2).poi(1:3) = [  7,  2,  8 ]
    geom.face(  3).n_poi = 3; allocate(geom.face(  3).poi(3)); geom.face(  3).poi(1:3) = [  2,  3,  8 ]
    geom.face(  4).n_poi = 3; allocate(geom.face(  4).poi(3)); geom.face(  4).poi(1:3) = [  8,  3,  9 ]
    geom.face(  5).n_poi = 3; allocate(geom.face(  5).poi(3)); geom.face(  5).poi(1:3) = [  3,  4,  9 ]
    geom.face(  6).n_poi = 3; allocate(geom.face(  6).poi(3)); geom.face(  6).poi(1:3) = [  9,  4, 10 ]
    geom.face(  7).n_poi = 3; allocate(geom.face(  7).poi(3)); geom.face(  7).poi(1:3) = [  4,  5, 10 ]
    geom.face(  8).n_poi = 3; allocate(geom.face(  8).poi(3)); geom.face(  8).poi(1:3) = [ 10,  5, 11 ]
    geom.face(  9).n_poi = 3; allocate(geom.face(  9).poi(3)); geom.face(  9).poi(1:3) = [  5,  6, 11 ]
    geom.face( 10).n_poi = 3; allocate(geom.face( 10).poi(3)); geom.face( 10).poi(1:3) = [ 11,  6, 12 ]
    geom.face( 11).n_poi = 3; allocate(geom.face( 11).poi(3)); geom.face( 11).poi(1:3) = [  6,  1, 12 ]
    geom.face( 12).n_poi = 3; allocate(geom.face( 12).poi(3)); geom.face( 12).poi(1:3) = [ 12,  1,  7 ]
    geom.face( 13).n_poi = 3; allocate(geom.face( 13).poi(3)); geom.face( 13).poi(1:3) = [  7,  8, 13 ]
    geom.face( 14).n_poi = 3; allocate(geom.face( 14).poi(3)); geom.face( 14).poi(1:3) = [ 13,  8, 14 ]
    geom.face( 15).n_poi = 3; allocate(geom.face( 15).poi(3)); geom.face( 15).poi(1:3) = [  8,  9, 14 ]
    geom.face( 16).n_poi = 3; allocate(geom.face( 16).poi(3)); geom.face( 16).poi(1:3) = [ 14,  9, 15 ]
    geom.face( 17).n_poi = 3; allocate(geom.face( 17).poi(3)); geom.face( 17).poi(1:3) = [  9, 10, 15 ]
    geom.face( 18).n_poi = 3; allocate(geom.face( 18).poi(3)); geom.face( 18).poi(1:3) = [ 15, 10, 16 ]
    geom.face( 19).n_poi = 3; allocate(geom.face( 19).poi(3)); geom.face( 19).poi(1:3) = [ 10, 11, 16 ]
    geom.face( 20).n_poi = 3; allocate(geom.face( 20).poi(3)); geom.face( 20).poi(1:3) = [ 16, 11, 17 ]
    geom.face( 21).n_poi = 3; allocate(geom.face( 21).poi(3)); geom.face( 21).poi(1:3) = [ 11, 12, 17 ]
    geom.face( 22).n_poi = 3; allocate(geom.face( 22).poi(3)); geom.face( 22).poi(1:3) = [ 17, 12, 18 ]
    geom.face( 23).n_poi = 3; allocate(geom.face( 23).poi(3)); geom.face( 23).poi(1:3) = [ 12,  7, 18 ]
    geom.face( 24).n_poi = 3; allocate(geom.face( 24).poi(3)); geom.face( 24).poi(1:3) = [ 18,  7, 13 ]
    geom.face( 25).n_poi = 3; allocate(geom.face( 25).poi(3)); geom.face( 25).poi(1:3) = [ 13, 14, 19 ]
    geom.face( 26).n_poi = 3; allocate(geom.face( 26).poi(3)); geom.face( 26).poi(1:3) = [ 19, 14, 20 ]
    geom.face( 27).n_poi = 3; allocate(geom.face( 27).poi(3)); geom.face( 27).poi(1:3) = [ 14, 15, 20 ]
    geom.face( 28).n_poi = 3; allocate(geom.face( 28).poi(3)); geom.face( 28).poi(1:3) = [ 20, 15, 21 ]
    geom.face( 29).n_poi = 3; allocate(geom.face( 29).poi(3)); geom.face( 29).poi(1:3) = [ 15, 16, 21 ]
    geom.face( 30).n_poi = 3; allocate(geom.face( 30).poi(3)); geom.face( 30).poi(1:3) = [ 21, 16, 22 ]
    geom.face( 31).n_poi = 3; allocate(geom.face( 31).poi(3)); geom.face( 31).poi(1:3) = [ 16, 17, 22 ]
    geom.face( 32).n_poi = 3; allocate(geom.face( 32).poi(3)); geom.face( 32).poi(1:3) = [ 22, 17, 23 ]
    geom.face( 33).n_poi = 3; allocate(geom.face( 33).poi(3)); geom.face( 33).poi(1:3) = [ 17, 18, 23 ]
    geom.face( 34).n_poi = 3; allocate(geom.face( 34).poi(3)); geom.face( 34).poi(1:3) = [ 23, 18, 24 ]
    geom.face( 35).n_poi = 3; allocate(geom.face( 35).poi(3)); geom.face( 35).poi(1:3) = [ 18, 13, 24 ]
    geom.face( 36).n_poi = 3; allocate(geom.face( 36).poi(3)); geom.face( 36).poi(1:3) = [ 24, 13, 19 ]
    geom.face( 37).n_poi = 3; allocate(geom.face( 37).poi(3)); geom.face( 37).poi(1:3) = [ 19, 20, 25 ]
    geom.face( 38).n_poi = 3; allocate(geom.face( 38).poi(3)); geom.face( 38).poi(1:3) = [ 25, 20, 26 ]
    geom.face( 39).n_poi = 3; allocate(geom.face( 39).poi(3)); geom.face( 39).poi(1:3) = [ 20, 21, 26 ]
    geom.face( 40).n_poi = 3; allocate(geom.face( 40).poi(3)); geom.face( 40).poi(1:3) = [ 26, 21, 27 ]
    geom.face( 41).n_poi = 3; allocate(geom.face( 41).poi(3)); geom.face( 41).poi(1:3) = [ 21, 22, 27 ]
    geom.face( 42).n_poi = 3; allocate(geom.face( 42).poi(3)); geom.face( 42).poi(1:3) = [ 27, 22, 28 ]
    geom.face( 43).n_poi = 3; allocate(geom.face( 43).poi(3)); geom.face( 43).poi(1:3) = [ 22, 23, 28 ]
    geom.face( 44).n_poi = 3; allocate(geom.face( 44).poi(3)); geom.face( 44).poi(1:3) = [ 28, 23, 29 ]
    geom.face( 45).n_poi = 3; allocate(geom.face( 45).poi(3)); geom.face( 45).poi(1:3) = [ 23, 24, 29 ]
    geom.face( 46).n_poi = 3; allocate(geom.face( 46).poi(3)); geom.face( 46).poi(1:3) = [ 29, 24, 30 ]
    geom.face( 47).n_poi = 3; allocate(geom.face( 47).poi(3)); geom.face( 47).poi(1:3) = [ 24, 19, 30 ]
    geom.face( 48).n_poi = 3; allocate(geom.face( 48).poi(3)); geom.face( 48).poi(1:3) = [ 30, 19, 25 ]
    geom.face( 49).n_poi = 3; allocate(geom.face( 49).poi(3)); geom.face( 49).poi(1:3) = [ 25, 26, 31 ]
    geom.face( 50).n_poi = 3; allocate(geom.face( 50).poi(3)); geom.face( 50).poi(1:3) = [ 31, 26, 32 ]
    geom.face( 51).n_poi = 3; allocate(geom.face( 51).poi(3)); geom.face( 51).poi(1:3) = [ 26, 27, 32 ]
    geom.face( 52).n_poi = 3; allocate(geom.face( 52).poi(3)); geom.face( 52).poi(1:3) = [ 32, 27, 33 ]
    geom.face( 53).n_poi = 3; allocate(geom.face( 53).poi(3)); geom.face( 53).poi(1:3) = [ 27, 28, 33 ]
    geom.face( 54).n_poi = 3; allocate(geom.face( 54).poi(3)); geom.face( 54).poi(1:3) = [ 33, 28, 34 ]
    geom.face( 55).n_poi = 3; allocate(geom.face( 55).poi(3)); geom.face( 55).poi(1:3) = [ 29, 35, 28 ]
    geom.face( 56).n_poi = 3; allocate(geom.face( 56).poi(3)); geom.face( 56).poi(1:3) = [ 28, 35, 34 ]
    geom.face( 57).n_poi = 3; allocate(geom.face( 57).poi(3)); geom.face( 57).poi(1:3) = [ 30, 36, 29 ]
    geom.face( 58).n_poi = 3; allocate(geom.face( 58).poi(3)); geom.face( 58).poi(1:3) = [ 29, 36, 35 ]
    geom.face( 59).n_poi = 3; allocate(geom.face( 59).poi(3)); geom.face( 59).poi(1:3) = [ 25, 31, 30 ]
    geom.face( 60).n_poi = 3; allocate(geom.face( 60).poi(3)); geom.face( 60).poi(1:3) = [ 30, 31, 36 ]
    geom.face( 61).n_poi = 3; allocate(geom.face( 61).poi(3)); geom.face( 61).poi(1:3) = [ 32, 38, 31 ]
    geom.face( 62).n_poi = 3; allocate(geom.face( 62).poi(3)); geom.face( 62).poi(1:3) = [ 31, 38, 37 ]
    geom.face( 63).n_poi = 3; allocate(geom.face( 63).poi(3)); geom.face( 63).poi(1:3) = [ 33, 39, 32 ]
    geom.face( 64).n_poi = 3; allocate(geom.face( 64).poi(3)); geom.face( 64).poi(1:3) = [ 32, 39, 38 ]
    geom.face( 65).n_poi = 3; allocate(geom.face( 65).poi(3)); geom.face( 65).poi(1:3) = [ 34, 40, 33 ]
    geom.face( 66).n_poi = 3; allocate(geom.face( 66).poi(3)); geom.face( 66).poi(1:3) = [ 33, 40, 39 ]
    geom.face( 67).n_poi = 3; allocate(geom.face( 67).poi(3)); geom.face( 67).poi(1:3) = [ 34, 35, 40 ]
    geom.face( 68).n_poi = 3; allocate(geom.face( 68).poi(3)); geom.face( 68).poi(1:3) = [ 40, 35, 41 ]
    geom.face( 69).n_poi = 3; allocate(geom.face( 69).poi(3)); geom.face( 69).poi(1:3) = [ 35, 36, 41 ]
    geom.face( 70).n_poi = 3; allocate(geom.face( 70).poi(3)); geom.face( 70).poi(1:3) = [ 41, 36, 42 ]
    geom.face( 71).n_poi = 3; allocate(geom.face( 71).poi(3)); geom.face( 71).poi(1:3) = [ 36, 31, 42 ]
    geom.face( 72).n_poi = 3; allocate(geom.face( 72).poi(3)); geom.face( 72).poi(1:3) = [ 42, 31, 37 ]
    geom.face( 73).n_poi = 3; allocate(geom.face( 73).poi(3)); geom.face( 73).poi(1:3) = [ 37, 38, 43 ]
    geom.face( 74).n_poi = 3; allocate(geom.face( 74).poi(3)); geom.face( 74).poi(1:3) = [ 43, 38, 44 ]
    geom.face( 75).n_poi = 3; allocate(geom.face( 75).poi(3)); geom.face( 75).poi(1:3) = [ 38, 39, 44 ]
    geom.face( 76).n_poi = 3; allocate(geom.face( 76).poi(3)); geom.face( 76).poi(1:3) = [ 44, 39, 45 ]
    geom.face( 77).n_poi = 3; allocate(geom.face( 77).poi(3)); geom.face( 77).poi(1:3) = [ 39, 40, 45 ]
    geom.face( 78).n_poi = 3; allocate(geom.face( 78).poi(3)); geom.face( 78).poi(1:3) = [ 45, 40, 46 ]
    geom.face( 79).n_poi = 3; allocate(geom.face( 79).poi(3)); geom.face( 79).poi(1:3) = [ 40, 41, 46 ]
    geom.face( 80).n_poi = 3; allocate(geom.face( 80).poi(3)); geom.face( 80).poi(1:3) = [ 46, 41, 47 ]
    geom.face( 81).n_poi = 3; allocate(geom.face( 81).poi(3)); geom.face( 81).poi(1:3) = [ 41, 42, 47 ]
    geom.face( 82).n_poi = 3; allocate(geom.face( 82).poi(3)); geom.face( 82).poi(1:3) = [ 47, 42, 48 ]
    geom.face( 83).n_poi = 3; allocate(geom.face( 83).poi(3)); geom.face( 83).poi(1:3) = [ 42, 37, 48 ]
    geom.face( 84).n_poi = 3; allocate(geom.face( 84).poi(3)); geom.face( 84).poi(1:3) = [ 48, 37, 43 ]
    geom.face( 85).n_poi = 3; allocate(geom.face( 85).poi(3)); geom.face( 85).poi(1:3) = [ 43, 44, 49 ]
    geom.face( 86).n_poi = 3; allocate(geom.face( 86).poi(3)); geom.face( 86).poi(1:3) = [ 49, 44, 50 ]
    geom.face( 87).n_poi = 3; allocate(geom.face( 87).poi(3)); geom.face( 87).poi(1:3) = [ 44, 45, 50 ]
    geom.face( 88).n_poi = 3; allocate(geom.face( 88).poi(3)); geom.face( 88).poi(1:3) = [ 50, 45, 51 ]
    geom.face( 89).n_poi = 3; allocate(geom.face( 89).poi(3)); geom.face( 89).poi(1:3) = [ 45, 46, 51 ]
    geom.face( 90).n_poi = 3; allocate(geom.face( 90).poi(3)); geom.face( 90).poi(1:3) = [ 51, 46, 52 ]
    geom.face( 91).n_poi = 3; allocate(geom.face( 91).poi(3)); geom.face( 91).poi(1:3) = [ 46, 47, 52 ]
    geom.face( 92).n_poi = 3; allocate(geom.face( 92).poi(3)); geom.face( 92).poi(1:3) = [ 52, 47, 53 ]
    geom.face( 93).n_poi = 3; allocate(geom.face( 93).poi(3)); geom.face( 93).poi(1:3) = [ 47, 48, 53 ]
    geom.face( 94).n_poi = 3; allocate(geom.face( 94).poi(3)); geom.face( 94).poi(1:3) = [ 53, 48, 54 ]
    geom.face( 95).n_poi = 3; allocate(geom.face( 95).poi(3)); geom.face( 95).poi(1:3) = [ 48, 43, 54 ]
    geom.face( 96).n_poi = 3; allocate(geom.face( 96).poi(3)); geom.face( 96).poi(1:3) = [ 54, 43, 49 ]
    geom.face( 97).n_poi = 3; allocate(geom.face( 97).poi(3)); geom.face( 97).poi(1:3) = [ 49, 50, 55 ]
    geom.face( 98).n_poi = 3; allocate(geom.face( 98).poi(3)); geom.face( 98).poi(1:3) = [ 55, 50, 56 ]
    geom.face( 99).n_poi = 3; allocate(geom.face( 99).poi(3)); geom.face( 99).poi(1:3) = [ 50, 51, 56 ]
    geom.face(100).n_poi = 3; allocate(geom.face(100).poi(3)); geom.face(100).poi(1:3) = [ 56, 51, 57 ]
    geom.face(101).n_poi = 3; allocate(geom.face(101).poi(3)); geom.face(101).poi(1:3) = [ 51, 52, 57 ]
    geom.face(102).n_poi = 3; allocate(geom.face(102).poi(3)); geom.face(102).poi(1:3) = [ 57, 52, 58 ]
    geom.face(103).n_poi = 3; allocate(geom.face(103).poi(3)); geom.face(103).poi(1:3) = [ 52, 53, 58 ]
    geom.face(104).n_poi = 3; allocate(geom.face(104).poi(3)); geom.face(104).poi(1:3) = [ 58, 53, 59 ]
    geom.face(105).n_poi = 3; allocate(geom.face(105).poi(3)); geom.face(105).poi(1:3) = [ 53, 54, 59 ]
    geom.face(106).n_poi = 3; allocate(geom.face(106).poi(3)); geom.face(106).poi(1:3) = [ 59, 54, 60 ]
    geom.face(107).n_poi = 3; allocate(geom.face(107).poi(3)); geom.face(107).poi(1:3) = [ 54, 49, 60 ]
    geom.face(108).n_poi = 3; allocate(geom.face(108).poi(3)); geom.face(108).poi(1:3) = [ 60, 49, 55 ]
    geom.face(109).n_poi = 3; allocate(geom.face(109).poi(3)); geom.face(109).poi(1:3) = [ 55, 56, 61 ]
    geom.face(110).n_poi = 3; allocate(geom.face(110).poi(3)); geom.face(110).poi(1:3) = [ 61, 56, 62 ]
    geom.face(111).n_poi = 3; allocate(geom.face(111).poi(3)); geom.face(111).poi(1:3) = [ 56, 57, 62 ]
    geom.face(112).n_poi = 3; allocate(geom.face(112).poi(3)); geom.face(112).poi(1:3) = [ 62, 57, 63 ]
    geom.face(113).n_poi = 3; allocate(geom.face(113).poi(3)); geom.face(113).poi(1:3) = [ 57, 58, 63 ]
    geom.face(114).n_poi = 3; allocate(geom.face(114).poi(3)); geom.face(114).poi(1:3) = [ 63, 58, 64 ]
    geom.face(115).n_poi = 3; allocate(geom.face(115).poi(3)); geom.face(115).poi(1:3) = [ 58, 59, 64 ]
    geom.face(116).n_poi = 3; allocate(geom.face(116).poi(3)); geom.face(116).poi(1:3) = [ 64, 59, 65 ]
    geom.face(117).n_poi = 3; allocate(geom.face(117).poi(3)); geom.face(117).poi(1:3) = [ 59, 60, 65 ]
    geom.face(118).n_poi = 3; allocate(geom.face(118).poi(3)); geom.face(118).poi(1:3) = [ 65, 60, 66 ]
    geom.face(119).n_poi = 3; allocate(geom.face(119).poi(3)); geom.face(119).poi(1:3) = [ 60, 55, 66 ]
    geom.face(120).n_poi = 3; allocate(geom.face(120).poi(3)); geom.face(120).poi(1:3) = [ 66, 55, 61 ]
    geom.face(121).n_poi = 3; allocate(geom.face(121).poi(3)); geom.face(121).poi(1:3) = [  2,  1, 67 ]
    geom.face(122).n_poi = 3; allocate(geom.face(122).poi(3)); geom.face(122).poi(1:3) = [  3,  2, 67 ]
    geom.face(123).n_poi = 3; allocate(geom.face(123).poi(3)); geom.face(123).poi(1:3) = [  4,  3, 67 ]
    geom.face(124).n_poi = 3; allocate(geom.face(124).poi(3)); geom.face(124).poi(1:3) = [  5,  4, 67 ]
    geom.face(125).n_poi = 3; allocate(geom.face(125).poi(3)); geom.face(125).poi(1:3) = [  6,  5, 67 ]
    geom.face(126).n_poi = 3; allocate(geom.face(126).poi(3)); geom.face(126).poi(1:3) = [  1,  6, 67 ]
    geom.face(127).n_poi = 3; allocate(geom.face(127).poi(3)); geom.face(127).poi(1:3) = [ 61, 62, 68 ]
    geom.face(128).n_poi = 3; allocate(geom.face(128).poi(3)); geom.face(128).poi(1:3) = [ 62, 63, 68 ]
    geom.face(129).n_poi = 3; allocate(geom.face(129).poi(3)); geom.face(129).poi(1:3) = [ 63, 64, 68 ]
    geom.face(130).n_poi = 3; allocate(geom.face(130).poi(3)); geom.face(130).poi(1:3) = [ 64, 65, 68 ]
    geom.face(131).n_poi = 3; allocate(geom.face(131).poi(3)); geom.face(131).poi(1:3) = [ 65, 66, 68 ]
    geom.face(132).n_poi = 3; allocate(geom.face(132).poi(3)); geom.face(132).poi(1:3) = [ 66, 61, 68 ]
end subroutine Exam_Asym_Bottle

! -----------------------------------------------------------------------------

! Example of Bunny
subroutine Exam_Asym_Bunny(prob, geom)
    type(ProbType), intent(inout) :: prob
    type(GeomType), intent(inout) :: geom

    character(10) :: char_sec, char_bp, char_start_bp

    write(unit=char_sec,      fmt = "(i10)"), prob.sel_sec
    write(unit=char_bp,       fmt = "(i10)"), prob.n_bp_edge
    write(unit=char_start_bp, fmt = "(i10)"), para_start_bp_ID

    prob.name_prob = "Bunny"
    prob.name_file = "Bunny"//&
        "_"//trim(adjustl(trim(char_sec)))//"cs"//&
        "_"//trim(adjustl(trim(char_bp)))//"bp"//&
        "_"//trim(para_vertex_design)

    ! Problem specified preset parameters
    if(para_vertex_design == "flat" .and. para_preset == "on") then
        para_junc_ang        = "max"    ! Junction gap modification for different arm angle
        para_const_edge_mesh = "off"    ! Constant edge length from polyhedra mesh
        para_unpaired_scaf   = "off"    ! Unpaired scaffold nucleotides
        para_n_base_tn       = 7
    end if

    ! Set geometric type and view (atom, cylinder size, move_x, move_y)
    call Mani_Set_View_Color(prob, [195, 153, 107], "xz")

    ! Allocate point and face structure
    geom.n_iniP = 70
    geom.n_face = 136

    allocate(geom.iniP(geom.n_iniP))
    allocate(geom.face(geom.n_face))

    ! Set point position vectors
    geom.iniP( 1).pos(1:3) = [  55.77528d0,  11.77481d0,  -2.16597d0 ]; geom.iniP( 2).pos(1:3) = [ -30.84909d0, -22.15223d0,  45.61294d0 ]
    geom.iniP( 3).pos(1:3) = [   9.65257d0, -33.59508d0, -36.64508d0 ]; geom.iniP( 4).pos(1:3) = [  -4.85174d0, -16.73194d0,  18.26052d0 ]
    geom.iniP( 5).pos(1:3) = [ -40.13385d0, -37.35918d0,  25.28683d0 ]; geom.iniP( 6).pos(1:3) = [  -7.16038d0,  26.12855d0,  -4.52480d0 ]
    geom.iniP( 7).pos(1:3) = [ -16.29459d0, -22.40317d0, -29.11689d0 ]; geom.iniP( 8).pos(1:3) = [  69.12527d0, -11.86371d0, -33.08173d0 ]
    geom.iniP( 9).pos(1:3) = [  21.69768d0, -10.55882d0,  33.16633d0 ]; geom.iniP(10).pos(1:3) = [  31.83564d0, -38.76444d0, -26.80824d0 ]
    geom.iniP(11).pos(1:3) = [ -26.63330d0,  26.63043d0,  46.56651d0 ]; geom.iniP(12).pos(1:3) = [  16.57851d0, -38.56369d0,  -5.42818d0 ]
    geom.iniP(13).pos(1:3) = [  55.32359d0,  -7.99924d0,   6.41617d0 ]; geom.iniP(14).pos(1:3) = [ -26.83405d0, -29.83099d0,  -7.38551d0 ]
    geom.iniP(15).pos(1:3) = [ -48.16392d0,   7.55902d0,  47.52008d0 ]; geom.iniP(16).pos(1:3) = [  -6.65850d0, -29.42948d0,  -1.86484d0 ]
    geom.iniP(17).pos(1:3) = [  18.33508d0, -24.05938d0,  17.45751d0 ]; geom.iniP(18).pos(1:3) = [   1.37156d0, -31.13587d0, -50.14563d0 ]
    geom.iniP(19).pos(1:3) = [ -24.42503d0, -29.47967d0, -46.18078d0 ]; geom.iniP(20).pos(1:3) = [  52.61344d0, -16.63156d0, -42.06537d0 ]
    geom.iniP(21).pos(1:3) = [ -18.10135d0,  -4.68684d0,  53.19132d0 ]; geom.iniP(22).pos(1:3) = [  40.66871d0, -14.67423d0,  20.46879d0 ]
    geom.iniP(23).pos(1:3) = [ -18.95455d0, -20.44585d0,  19.36465d0 ]; geom.iniP(24).pos(1:3) = [  60.29219d0,  -4.68684d0, -16.46953d0 ]
    geom.iniP(25).pos(1:3) = [ -54.23666d0,  -3.28157d0,  25.68833d0 ]; geom.iniP(26).pos(1:3) = [ -10.32222d0,  -1.17368d0,  37.58287d0 ]
    geom.iniP(27).pos(1:3) = [  43.32867d0, -31.48719d0,  -4.62518d0 ]; geom.iniP(28).pos(1:3) = [ -50.82388d0,  -4.88759d0,   6.26560d0 ]
    geom.iniP(29).pos(1:3) = [  66.16418d0,   3.99568d0, -38.40165d0 ]; geom.iniP(30).pos(1:3) = [  52.01119d0,  14.68571d0, -32.98136d0 ]
    geom.iniP(31).pos(1:3) = [  39.36383d0,  25.87761d0, -40.15823d0 ]; geom.iniP(32).pos(1:3) = [ -10.02110d0,  -0.42086d0,  23.78119d0 ]
    geom.iniP(33).pos(1:3) = [ -55.14004d0, -22.85487d0,  22.92800d0 ]; geom.iniP(34).pos(1:3) = [ -47.66204d0,   5.60169d0, -16.01784d0 ]
    geom.iniP(35).pos(1:3) = [  46.94220d0,  12.12612d0,  10.38101d0 ]; geom.iniP(36).pos(1:3) = [  30.63113d0,   7.30808d0,  26.99322d0 ]
    geom.iniP(37).pos(1:3) = [ -41.68968d0,  12.62800d0,  12.13759d0 ]; geom.iniP(38).pos(1:3) = [ -24.77635d0,   8.81372d0, -34.03530d0 ]
    geom.iniP(39).pos(1:3) = [ -48.81636d0, -14.02179d0,  45.06087d0 ]; geom.iniP(40).pos(1:3) = [ -40.58554d0, -23.25637d0,   5.76373d0 ]
    geom.iniP(41).pos(1:3) = [ -19.65718d0,  10.21898d0,  37.33193d0 ]; geom.iniP(42).pos(1:3) = [ -23.97334d0,  18.95168d0,  10.07989d0 ]
    geom.iniP(43).pos(1:3) = [  17.78302d0,  28.33682d0,   2.50151d0 ]; geom.iniP(44).pos(1:3) = [ -37.17277d0,  31.34810d0,  56.90523d0 ]
    geom.iniP(45).pos(1:3) = [ -40.93686d0, -21.39942d0, -17.97517d0 ]; geom.iniP(46).pos(1:3) = [  -5.40381d0,  19.70450d0, -29.97008d0 ]
    geom.iniP(47).pos(1:3) = [  30.68132d0,  18.85130d0,  17.80883d0 ]; geom.iniP(48).pos(1:3) = [   2.52589d0,  39.32798d0, -14.16088d0 ]
    geom.iniP(49).pos(1:3) = [ -13.33350d0,  11.52387d0,  22.52649d0 ]; geom.iniP(50).pos(1:3) = [  69.47658d0,  -0.82237d0, -22.54227d0 ]
    geom.iniP(51).pos(1:3) = [   3.98134d0,  18.34942d0,  18.10996d0 ]; geom.iniP(52).pos(1:3) = [  -9.61959d0,  28.48739d0, -50.24600d0 ]
    geom.iniP(53).pos(1:3) = [   8.59863d0,  34.76088d0, -34.23605d0 ]; geom.iniP(54).pos(1:3) = [  21.64749d0,  36.11595d0, -10.89867d0 ]
    geom.iniP(55).pos(1:3) = [  45.03506d0,  23.81991d0,  -5.27762d0 ]; geom.iniP(56).pos(1:3) = [ -37.82521d0,  20.95920d0, -10.29641d0 ]
    geom.iniP(57).pos(1:3) = [  20.44298d0,  20.85882d0, -49.79431d0 ]; geom.iniP(58).pos(1:3) = [  -4.65099d0,   6.50507d0, -46.63247d0 ]
    geom.iniP(59).pos(1:3) = [ -23.92315d0,  12.22650d0, -50.74788d0 ]; geom.iniP(60).pos(1:3) = [  39.91589d0,   3.14248d0, -51.04901d0 ]
    geom.iniP(61).pos(1:3) = [ -29.19288d0, -11.26145d0, -49.74412d0 ]; geom.iniP(62).pos(1:3) = [  32.68883d0, -26.97028d0, -49.24225d0 ]
    geom.iniP(63).pos(1:3) = [ -42.49269d0,  19.65431d0,  34.27047d0 ]; geom.iniP(64).pos(1:3) = [ -16.44515d0,  22.71577d0,  47.01820d0 ]
    geom.iniP(65).pos(1:3) = [  -2.49291d0,  15.18758d0,  60.56894d0 ]; geom.iniP(66).pos(1:3) = [  42.97736d0,  -0.37067d0,  16.70469d0 ]
    geom.iniP(67).pos(1:3) = [ -29.99589d0,  12.07593d0,  33.91915d0 ]; geom.iniP(68).pos(1:3) = [   9.25107d0, -13.46972d0, -47.78680d0 ]
    geom.iniP(69).pos(1:3) = [ -37.82521d0,   3.84511d0,  49.37704d0 ]; geom.iniP(70).pos(1:3) = [ -28.64082d0,   0.63308d0,  51.68568d0 ]

    ! Set face connnectivity
    geom.face(  1).n_poi = 3; allocate(geom.face(  1).poi(3)); geom.face(  1).poi(1:3) = [ 36, 22, 66 ]
    geom.face(  2).n_poi = 3; allocate(geom.face(  2).poi(3)); geom.face(  2).poi(1:3) = [ 11, 69, 67 ]
    geom.face(  3).n_poi = 3; allocate(geom.face(  3).poi(3)); geom.face(  3).poi(1:3) = [ 53, 57, 52 ]
    geom.face(  4).n_poi = 3; allocate(geom.face(  4).poi(3)); geom.face(  4).poi(1:3) = [ 13, 24,  1 ]
    geom.face(  5).n_poi = 3; allocate(geom.face(  5).poi(3)); geom.face(  5).poi(1:3) = [ 32,  9, 51 ]
    geom.face(  6).n_poi = 3; allocate(geom.face(  6).poi(3)); geom.face(  6).poi(1:3) = [ 31, 55,  1 ]
    geom.face(  7).n_poi = 3; allocate(geom.face(  7).poi(3)); geom.face(  7).poi(1:3) = [ 30, 24, 50 ]
    geom.face(  8).n_poi = 3; allocate(geom.face(  8).poi(3)); geom.face(  8).poi(1:3) = [ 23,  5, 40 ]
    geom.face(  9).n_poi = 3; allocate(geom.face(  9).poi(3)); geom.face(  9).poi(1:3) = [ 20, 27, 10 ]
    geom.face( 10).n_poi = 3; allocate(geom.face( 10).poi(3)); geom.face( 10).poi(1:3) = [ 17, 12, 27 ]
    geom.face( 11).n_poi = 3; allocate(geom.face( 11).poi(3)); geom.face( 11).poi(1:3) = [  5, 39, 33 ]
    geom.face( 12).n_poi = 3; allocate(geom.face( 12).poi(3)); geom.face( 12).poi(1:3) = [ 49, 32, 51 ]
    geom.face( 13).n_poi = 3; allocate(geom.face( 13).poi(3)); geom.face( 13).poi(1:3) = [ 68, 58, 57 ]
    geom.face( 14).n_poi = 3; allocate(geom.face( 14).poi(3)); geom.face( 14).poi(1:3) = [ 68, 57, 60 ]
    geom.face( 15).n_poi = 3; allocate(geom.face( 15).poi(3)); geom.face( 15).poi(1:3) = [ 68, 60, 62 ]
    geom.face( 16).n_poi = 3; allocate(geom.face( 16).poi(3)); geom.face( 16).poi(1:3) = [ 68, 62, 18 ]
    geom.face( 17).n_poi = 3; allocate(geom.face( 17).poi(3)); geom.face( 17).poi(1:3) = [ 68, 18, 61 ]
    geom.face( 18).n_poi = 3; allocate(geom.face( 18).poi(3)); geom.face( 18).poi(1:3) = [ 68, 61, 58 ]
    geom.face( 19).n_poi = 3; allocate(geom.face( 19).poi(3)); geom.face( 19).poi(1:3) = [  3, 12, 16 ]
    geom.face( 20).n_poi = 3; allocate(geom.face( 20).poi(3)); geom.face( 20).poi(1:3) = [ 23, 40, 14 ]
    geom.face( 21).n_poi = 3; allocate(geom.face( 21).poi(3)); geom.face( 21).poi(1:3) = [ 27, 22, 17 ]
    geom.face( 22).n_poi = 3; allocate(geom.face( 22).poi(3)); geom.face( 22).poi(1:3) = [ 48, 43, 54 ]
    geom.face( 23).n_poi = 3; allocate(geom.face( 23).poi(3)); geom.face( 23).poi(1:3) = [ 30, 31,  1 ]
    geom.face( 24).n_poi = 3; allocate(geom.face( 24).poi(3)); geom.face( 24).poi(1:3) = [ 10, 27, 12 ]
    geom.face( 25).n_poi = 3; allocate(geom.face( 25).poi(3)); geom.face( 25).poi(1:3) = [ 57, 58, 52 ]
    geom.face( 26).n_poi = 3; allocate(geom.face( 26).poi(3)); geom.face( 26).poi(1:3) = [ 62,  3, 18 ]
    geom.face( 27).n_poi = 3; allocate(geom.face( 27).poi(3)); geom.face( 27).poi(1:3) = [ 56, 42,  6 ]
    geom.face( 28).n_poi = 3; allocate(geom.face( 28).poi(3)); geom.face( 28).poi(1:3) = [ 47, 36, 35 ]
    geom.face( 29).n_poi = 3; allocate(geom.face( 29).poi(3)); geom.face( 29).poi(1:3) = [ 20, 24, 27 ]
    geom.face( 30).n_poi = 3; allocate(geom.face( 30).poi(3)); geom.face( 30).poi(1:3) = [  4, 16, 17 ]
    geom.face( 31).n_poi = 3; allocate(geom.face( 31).poi(3)); geom.face( 31).poi(1:3) = [ 26, 65, 21 ]
    geom.face( 32).n_poi = 3; allocate(geom.face( 32).poi(3)); geom.face( 32).poi(1:3) = [  6, 48, 46 ]
    geom.face( 33).n_poi = 3; allocate(geom.face( 33).poi(3)); geom.face( 33).poi(1:3) = [ 47, 51, 36 ]
    geom.face( 34).n_poi = 3; allocate(geom.face( 34).poi(3)); geom.face( 34).poi(1:3) = [ 43, 47, 55 ]
    geom.face( 35).n_poi = 3; allocate(geom.face( 35).poi(3)); geom.face( 35).poi(1:3) = [  8, 29, 50 ]
    geom.face( 36).n_poi = 3; allocate(geom.face( 36).poi(3)); geom.face( 36).poi(1:3) = [ 28, 33, 25 ]
    geom.face( 37).n_poi = 3; allocate(geom.face( 37).poi(3)); geom.face( 37).poi(1:3) = [ 22, 27, 13 ]
    geom.face( 38).n_poi = 3; allocate(geom.face( 38).poi(3)); geom.face( 38).poi(1:3) = [ 20, 62, 60 ]
    geom.face( 39).n_poi = 3; allocate(geom.face( 39).poi(3)); geom.face( 39).poi(1:3) = [  7, 38, 61 ]
    geom.face( 40).n_poi = 3; allocate(geom.face( 40).poi(3)); geom.face( 40).poi(1:3) = [ 40,  5, 33 ]
    geom.face( 41).n_poi = 3; allocate(geom.face( 41).poi(3)); geom.face( 41).poi(1:3) = [ 29,  8, 60 ]
    geom.face( 42).n_poi = 3; allocate(geom.face( 42).poi(3)); geom.face( 42).poi(1:3) = [ 42, 37, 49 ]
    geom.face( 43).n_poi = 3; allocate(geom.face( 43).poi(3)); geom.face( 43).poi(1:3) = [ 58, 61, 59 ]
    geom.face( 44).n_poi = 3; allocate(geom.face( 44).poi(3)); geom.face( 44).poi(1:3) = [ 15, 39, 69 ]
    geom.face( 45).n_poi = 3; allocate(geom.face( 45).poi(3)); geom.face( 45).poi(1:3) = [ 47, 43, 51 ]
    geom.face( 46).n_poi = 3; allocate(geom.face( 46).poi(3)); geom.face( 46).poi(1:3) = [ 40, 45, 14 ]
    geom.face( 47).n_poi = 3; allocate(geom.face( 47).poi(3)); geom.face( 47).poi(1:3) = [ 35, 13,  1 ]
    geom.face( 48).n_poi = 3; allocate(geom.face( 48).poi(3)); geom.face( 48).poi(1:3) = [ 22,  9, 17 ]
    geom.face( 49).n_poi = 3; allocate(geom.face( 49).poi(3)); geom.face( 49).poi(1:3) = [  1, 55, 35 ]
    geom.face( 50).n_poi = 3; allocate(geom.face( 50).poi(3)); geom.face( 50).poi(1:3) = [ 26, 23, 32 ]
    geom.face( 51).n_poi = 3; allocate(geom.face( 51).poi(3)); geom.face( 51).poi(1:3) = [ 16, 14,  7 ]
    geom.face( 52).n_poi = 3; allocate(geom.face( 52).poi(3)); geom.face( 52).poi(1:3) = [ 48,  6, 43 ]
    geom.face( 53).n_poi = 3; allocate(geom.face( 53).poi(3)); geom.face( 53).poi(1:3) = [ 36,  9, 22 ]
    geom.face( 54).n_poi = 3; allocate(geom.face( 54).poi(3)); geom.face( 54).poi(1:3) = [  1, 24, 30 ]
    geom.face( 55).n_poi = 3; allocate(geom.face( 55).poi(3)); geom.face( 55).poi(1:3) = [ 45, 38,  7 ]
    geom.face( 56).n_poi = 3; allocate(geom.face( 56).poi(3)); geom.face( 56).poi(1:3) = [ 54, 55, 31 ]
    geom.face( 57).n_poi = 3; allocate(geom.face( 57).poi(3)); geom.face( 57).poi(1:3) = [ 44, 63, 15 ]
    geom.face( 58).n_poi = 3; allocate(geom.face( 58).poi(3)); geom.face( 58).poi(1:3) = [ 60, 57, 31 ]
    geom.face( 59).n_poi = 3; allocate(geom.face( 59).poi(3)); geom.face( 59).poi(1:3) = [ 59, 38, 46 ]
    geom.face( 60).n_poi = 3; allocate(geom.face( 60).poi(3)); geom.face( 60).poi(1:3) = [ 46, 52, 59 ]
    geom.face( 61).n_poi = 3; allocate(geom.face( 61).poi(3)); geom.face( 61).poi(1:3) = [ 10, 62, 20 ]
    geom.face( 62).n_poi = 3; allocate(geom.face( 62).poi(3)); geom.face( 62).poi(1:3) = [ 11, 67, 63 ]
    geom.face( 63).n_poi = 3; allocate(geom.face( 63).poi(3)); geom.face( 63).poi(1:3) = [ 23, 26,  2 ]
    geom.face( 64).n_poi = 3; allocate(geom.face( 64).poi(3)); geom.face( 64).poi(1:3) = [ 24, 13, 27 ]
    geom.face( 65).n_poi = 3; allocate(geom.face( 65).poi(3)); geom.face( 65).poi(1:3) = [ 45, 34, 38 ]
    geom.face( 66).n_poi = 3; allocate(geom.face( 66).poi(3)); geom.face( 66).poi(1:3) = [  9, 32,  4 ]
    geom.face( 67).n_poi = 3; allocate(geom.face( 67).poi(3)); geom.face( 67).poi(1:3) = [  4, 17,  9 ]
    geom.face( 68).n_poi = 3; allocate(geom.face( 68).poi(3)); geom.face( 68).poi(1:3) = [ 16,  7,  3 ]
    geom.face( 69).n_poi = 3; allocate(geom.face( 69).poi(3)); geom.face( 69).poi(1:3) = [ 48, 54, 53 ]
    geom.face( 70).n_poi = 3; allocate(geom.face( 70).poi(3)); geom.face( 70).poi(1:3) = [ 16, 23, 14 ]
    geom.face( 71).n_poi = 3; allocate(geom.face( 71).poi(3)); geom.face( 71).poi(1:3) = [ 10, 12,  3 ]
    geom.face( 72).n_poi = 3; allocate(geom.face( 72).poi(3)); geom.face( 72).poi(1:3) = [ 49, 51, 42 ]
    geom.face( 73).n_poi = 3; allocate(geom.face( 73).poi(3)); geom.face( 73).poi(1:3) = [ 45, 40, 28 ]
    geom.face( 74).n_poi = 3; allocate(geom.face( 74).poi(3)); geom.face( 74).poi(1:3) = [ 14, 45,  7 ]
    geom.face( 75).n_poi = 3; allocate(geom.face( 75).poi(3)); geom.face( 75).poi(1:3) = [ 55, 47, 35 ]
    geom.face( 76).n_poi = 3; allocate(geom.face( 76).poi(3)); geom.face( 76).poi(1:3) = [ 23,  4, 32 ]
    geom.face( 77).n_poi = 3; allocate(geom.face( 77).poi(3)); geom.face( 77).poi(1:3) = [ 26, 21,  2 ]
    geom.face( 78).n_poi = 3; allocate(geom.face( 78).poi(3)); geom.face( 78).poi(1:3) = [ 59, 52, 58 ]
    geom.face( 79).n_poi = 3; allocate(geom.face( 79).poi(3)); geom.face( 79).poi(1:3) = [ 50, 24,  8 ]
    geom.face( 80).n_poi = 3; allocate(geom.face( 80).poi(3)); geom.face( 80).poi(1:3) = [  5, 23,  2 ]
    geom.face( 81).n_poi = 3; allocate(geom.face( 81).poi(3)); geom.face( 81).poi(1:3) = [ 13, 35, 66 ]
    geom.face( 82).n_poi = 3; allocate(geom.face( 82).poi(3)); geom.face( 82).poi(1:3) = [ 43,  6, 51 ]
    geom.face( 83).n_poi = 3; allocate(geom.face( 83).poi(3)); geom.face( 83).poi(1:3) = [ 54, 43, 55 ]
    geom.face( 84).n_poi = 3; allocate(geom.face( 84).poi(3)); geom.face( 84).poi(1:3) = [ 46, 53, 52 ]
    geom.face( 85).n_poi = 3; allocate(geom.face( 85).poi(3)); geom.face( 85).poi(1:3) = [  8, 24, 20 ]
    geom.face( 86).n_poi = 3; allocate(geom.face( 86).poi(3)); geom.face( 86).poi(1:3) = [ 39,  5,  2 ]
    geom.face( 87).n_poi = 3; allocate(geom.face( 87).poi(3)); geom.face( 87).poi(1:3) = [ 38, 56, 46 ]
    geom.face( 88).n_poi = 3; allocate(geom.face( 88).poi(3)); geom.face( 88).poi(1:3) = [ 15, 25, 39 ]
    geom.face( 89).n_poi = 3; allocate(geom.face( 89).poi(3)); geom.face( 89).poi(1:3) = [ 19,  7, 61 ]
    geom.face( 90).n_poi = 3; allocate(geom.face( 90).poi(3)); geom.face( 90).poi(1:3) = [ 59, 61, 38 ]
    geom.face( 91).n_poi = 3; allocate(geom.face( 91).poi(3)); geom.face( 91).poi(1:3) = [ 30, 60, 31 ]
    geom.face( 92).n_poi = 3; allocate(geom.face( 92).poi(3)); geom.face( 92).poi(1:3) = [ 10,  3, 62 ]
    geom.face( 93).n_poi = 3; allocate(geom.face( 93).poi(3)); geom.face( 93).poi(1:3) = [ 42, 56, 37 ]
    geom.face( 94).n_poi = 3; allocate(geom.face( 94).poi(3)); geom.face( 94).poi(1:3) = [ 31, 53, 54 ]
    geom.face( 95).n_poi = 3; allocate(geom.face( 95).poi(3)); geom.face( 95).poi(1:3) = [ 30, 29, 60 ]
    geom.face( 96).n_poi = 3; allocate(geom.face( 96).poi(3)); geom.face( 96).poi(1:3) = [ 53, 46, 48 ]
    geom.face( 97).n_poi = 3; allocate(geom.face( 97).poi(3)); geom.face( 97).poi(1:3) = [ 37, 25, 63 ]
    geom.face( 98).n_poi = 3; allocate(geom.face( 98).poi(3)); geom.face( 98).poi(1:3) = [ 45, 28, 34 ]
    geom.face( 99).n_poi = 3; allocate(geom.face( 99).poi(3)); geom.face( 99).poi(1:3) = [ 39, 25, 33 ]
    geom.face(100).n_poi = 3; allocate(geom.face(100).poi(3)); geom.face(100).poi(1:3) = [ 60,  8, 20 ]
    geom.face(101).n_poi = 3; allocate(geom.face(101).poi(3)); geom.face(101).poi(1:3) = [ 33, 28, 40 ]
    geom.face(102).n_poi = 3; allocate(geom.face(102).poi(3)); geom.face(102).poi(1:3) = [ 23, 16,  4 ]
    geom.face(103).n_poi = 3; allocate(geom.face(103).poi(3)); geom.face(103).poi(1:3) = [ 49, 41, 26 ]
    geom.face(104).n_poi = 3; allocate(geom.face(104).poi(3)); geom.face(104).poi(1:3) = [ 32, 49, 26 ]
    geom.face(105).n_poi = 3; allocate(geom.face(105).poi(3)); geom.face(105).poi(1:3) = [ 30, 50, 29 ]
    geom.face(106).n_poi = 3; allocate(geom.face(106).poi(3)); geom.face(106).poi(1:3) = [ 18,  3,  7 ]
    geom.face(107).n_poi = 3; allocate(geom.face(107).poi(3)); geom.face(107).poi(1:3) = [ 61, 18, 19 ]
    geom.face(108).n_poi = 3; allocate(geom.face(108).poi(3)); geom.face(108).poi(1:3) = [  7, 19, 18 ]
    geom.face(109).n_poi = 3; allocate(geom.face(109).poi(3)); geom.face(109).poi(1:3) = [ 37, 56, 34 ]
    geom.face(110).n_poi = 3; allocate(geom.face(110).poi(3)); geom.face(110).poi(1:3) = [ 28, 37, 34 ]
    geom.face(111).n_poi = 3; allocate(geom.face(111).poi(3)); geom.face(111).poi(1:3) = [ 12, 17, 16 ]
    geom.face(112).n_poi = 3; allocate(geom.face(112).poi(3)); geom.face(112).poi(1:3) = [ 38, 34, 56 ]
    geom.face(113).n_poi = 3; allocate(geom.face(113).poi(3)); geom.face(113).poi(1:3) = [ 25, 15, 63 ]
    geom.face(114).n_poi = 3; allocate(geom.face(114).poi(3)); geom.face(114).poi(1:3) = [ 56,  6, 46 ]
    geom.face(115).n_poi = 3; allocate(geom.face(115).poi(3)); geom.face(115).poi(1:3) = [ 25, 37, 28 ]
    geom.face(116).n_poi = 3; allocate(geom.face(116).poi(3)); geom.face(116).poi(1:3) = [ 64, 26, 41 ]
    geom.face(117).n_poi = 3; allocate(geom.face(117).poi(3)); geom.face(117).poi(1:3) = [ 41, 49, 67 ]
    geom.face(118).n_poi = 3; allocate(geom.face(118).poi(3)); geom.face(118).poi(1:3) = [ 64, 65, 26 ]
    geom.face(119).n_poi = 3; allocate(geom.face(119).poi(3)); geom.face(119).poi(1:3) = [ 51,  9, 36 ]
    geom.face(120).n_poi = 3; allocate(geom.face(120).poi(3)); geom.face(120).poi(1:3) = [ 51,  6, 42 ]
    geom.face(121).n_poi = 3; allocate(geom.face(121).poi(3)); geom.face(121).poi(1:3) = [ 31, 57, 53 ]
    geom.face(122).n_poi = 3; allocate(geom.face(122).poi(3)); geom.face(122).poi(1:3) = [ 66, 35, 36 ]
    geom.face(123).n_poi = 3; allocate(geom.face(123).poi(3)); geom.face(123).poi(1:3) = [ 66, 22, 13 ]
    geom.face(124).n_poi = 3; allocate(geom.face(124).poi(3)); geom.face(124).poi(1:3) = [ 44, 11, 63 ]
    geom.face(125).n_poi = 3; allocate(geom.face(125).poi(3)); geom.face(125).poi(1:3) = [ 65, 70, 21 ]
    geom.face(126).n_poi = 3; allocate(geom.face(126).poi(3)); geom.face(126).poi(1:3) = [ 63, 67, 37 ]
    geom.face(127).n_poi = 3; allocate(geom.face(127).poi(3)); geom.face(127).poi(1:3) = [ 67, 49, 37 ]
    geom.face(128).n_poi = 3; allocate(geom.face(128).poi(3)); geom.face(128).poi(1:3) = [ 11, 44, 69 ]
    geom.face(129).n_poi = 3; allocate(geom.face(129).poi(3)); geom.face(129).poi(1:3) = [ 41, 69, 70 ]
    geom.face(130).n_poi = 3; allocate(geom.face(130).poi(3)); geom.face(130).poi(1:3) = [ 64, 41, 70 ]
    geom.face(131).n_poi = 3; allocate(geom.face(131).poi(3)); geom.face(131).poi(1:3) = [ 69, 44, 15 ]
    geom.face(132).n_poi = 3; allocate(geom.face(132).poi(3)); geom.face(132).poi(1:3) = [ 64, 70, 65 ]
    geom.face(133).n_poi = 3; allocate(geom.face(133).poi(3)); geom.face(133).poi(1:3) = [ 41, 67, 69 ]
    geom.face(134).n_poi = 3; allocate(geom.face(134).poi(3)); geom.face(134).poi(1:3) = [ 70,  2, 21 ]
    geom.face(135).n_poi = 3; allocate(geom.face(135).poi(3)); geom.face(135).poi(1:3) = [ 69, 39, 70 ]
    geom.face(136).n_poi = 3; allocate(geom.face(136).poi(3)); geom.face(136).poi(1:3) = [ 70, 39,  2 ]
end subroutine Exam_Asym_Bunny

! -----------------------------------------------------------------------------

end module Exam_Asym