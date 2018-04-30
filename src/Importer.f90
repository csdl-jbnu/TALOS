!
! =============================================================================
!
! Module - Importer
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
module Importer

    use Ifport

    use Data_Prob
    use Data_Geom

    use Math

    implicit none

    public Importer_PLY
    public Importer_STL
    public Importer_WRL
    public Importer_GEO

contains

! -----------------------------------------------------------------------------

! import PLY format that has surface mesh information
subroutine Importer_PLY(prob, geom)
    type(ProbType), intent(inout) :: prob
    type(GeomType), intent(inout) :: geom

    integer :: i, status, npoint
    character(200) :: ctemp, path

    ! mesh data structure
    type :: MeshType
        integer :: cn(100)   ! maximum connectivity
    end type MeshType

    ! 1st: # of meshes, 2nd: points
    type(MeshType), allocatable, dimension (:) :: Basepair_con

    path = "input/"//trim(prob.name_file)//"."//trim(prob.type_file)
    !path = trim(prob.name_file)//"."//trim(prob.type_file)
    open(unit=1001, file=path, form="formatted")

    do
        read(1001, "(a100)", IOSTAT=status), ctemp

        ! negative value, means the end-of-file (EOF) mark was read
        if(status < 0) exit

        if(index(ctemp, "format")) then

            ! read the number of points
            read(1001, *), ctemp, ctemp, geom.n_iniP
            allocate(geom.iniP(geom.n_iniP))

        else if(index(ctemp, "property float32 z") .or. index(ctemp, "property float z")) then

            ! read the number of faces
            read(1001, *), ctemp, ctemp, geom.n_face

        else if(index(ctemp,"end_header")) then

            ! read point
            do i = 1, geom.n_iniP
                read(1001, *), geom.iniP(i).pos(1:3)
            end do

            allocate(geom.face(geom.n_face))
            allocate(Basepair_con(geom.n_face))

            ! read # of vectices in the mesh and connectivity
            do i = 1, geom.n_face
                read(1001, *), npoint, Basepair_con(i).cn(1:npoint)

                geom.face(i).n_poi = npoint
                allocate(geom.face(i).poi(npoint))

                geom.face(i).poi(1:npoint) = Basepair_con(i).cn(1:npoint)
            end do
        end if
    end do

    deallocate(Basepair_con)
    close(unit=1001)
end subroutine Importer_PLY

! -----------------------------------------------------------------------------

! import STL format using meshconv
subroutine Importer_STL(prob)
    type(ProbType), intent(inout) :: prob

    logical :: results

    ! run meshconv to generate *.PLY fileformat
    results = SYSTEMQQ(trim("tools/meshconv -c ply input/")// &
        trim(prob.name_file)//"."//trim(prob.type_file)//trim(" -ascii"))

    ! change file type to PLY
    prob.type_file = "ply"
end subroutine Importer_STL

! -----------------------------------------------------------------------------

! import WRL format using meshconv
subroutine Importer_WRL(prob)
    type(ProbType), intent(inout) :: prob

    logical :: results

    ! run meshconv to generate *.PLY fileformat
    results = SYSTEMQQ(trim("tools/meshconv -c ply input/")// &
        trim(prob.name_file)//"."//trim(prob.type_file)//trim(" -ascii"))

    ! change file type to PLY
    prob.type_file = "ply"
end subroutine Importer_WRL

! -----------------------------------------------------------------------------

! import geom format that is standard for PERDIX
subroutine Importer_GEO(prob, geom)
    type(ProbType), intent(inout) :: prob
    type(GeomType), intent(inout) :: geom

    integer :: i, number, npoint
    character(200) :: path

    ! mesh data structure
    type :: MeshType
        integer :: cn(100)   ! maximum connectivity
    end type MeshType

    ! 1st: # of meshes, 2nd: points
    type(MeshType), allocatable, dimension (:) :: Basepair_con

    path = "input/"//trim(prob.name_file)//"."//trim(prob.type_file)
    open(unit=1002, file=path, form="formatted")

    ! read points
    read(1002, *), geom.n_iniP
    allocate(geom.iniP(geom.n_iniP))

    do i = 1, geom.n_iniP
        read(1002, *), number, geom.iniP(i).pos(1:3)
    end do

    ! read face
    read(1002, *), geom.n_face
    allocate(geom.face(geom.n_face))
    allocate(Basepair_con(geom.n_face))

    ! read # of vectices in the mesh and connectivity
    do i = 1, geom.n_face
        read(1002, *), npoint, Basepair_con(i).cn(1:npoint)

        geom.face(i).n_poi = npoint
        allocate(geom.face(i).poi(npoint))

        geom.face(i).poi(1:npoint) = Basepair_con(i).cn(1:npoint)
    end do

    deallocate(Basepair_con)
end subroutine Importer_GEO

! -----------------------------------------------------------------------------

end module Importer