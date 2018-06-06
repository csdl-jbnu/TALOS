!
! =============================================================================
!
! Module - Data_Geom
! Last Updated : 04/10/2018, by Hyungmin Jun (hyungminjun@outlook.com)
!
! =============================================================================
!
! This is part of TALOS, which allows scientists to build and solve
! the sequence design of complex DNAnanostructures.
! Copyright 2018 Hyungmin Jun. All rights reserved.
!
! License - GPL version 3
! TALOS is free software: you can redistribute it and/or modify it under
! the terms of the GNU General Public License as published by the Free Software
! Foundation, either version 3 of the License, or any later version.
! TALOS is distributed in the hope that it will be useful, but WITHOUT
! ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS
! FOR A PARTICULAR PURPOSE. See the GNU General Public License
! for more details.
! You should have received a copy of the GNU General Public License along with
! this program. If not, see <http://www.gnu.org/licenses/>.
!
! -----------------------------------------------------------------------------
!
module Data_Geom

! -----------------------------------------------------------------------------

    ! Section data for arbitrary cross-section
    type :: SecType
        character(len=10) :: types          ! Lattice type, squre or honeycomb

        integer :: dir                      ! Section convection of caDNAnano
        integer :: maxR, minR               ! Maximum and minimum row
        integer :: maxC, minC               ! Maximum and minimum column
        integer :: n_row, n_col             ! Size of row and column
        integer :: ref_row                  ! Reference row to set t-axis
        integer :: ref_maxC, ref_minC       ! Maximum and minimum column in reference row

        integer, allocatable :: id(:)       ! Section ID
        integer, allocatable :: posR(:)     ! Row position number
        integer, allocatable :: posC(:)     ! Column position number

        ! Connetivity for self connection route
        ! -1 : neighbor connection, num : section number to be connected for self-connection
        integer, allocatable :: conn(:)
    end type SecType

! -----------------------------------------------------------------------------

    ! Point type data structure
    type :: PointType
        double precision :: pos(3)      ! Position vector
        double precision :: ori_pos(3)  ! Original position vector
    end type PointType

! -----------------------------------------------------------------------------

    ! Line type data structure
    type :: LineType
        integer :: iniL             ! Inital line number
        integer :: sec              ! Cross-section ID
        integer :: iniP(2)          ! Initial point connectivity
        integer :: poi(2)           ! Point connectivity
        integer :: neiF(2)          ! Neighbor faces  (direction)
        integer :: neiP(2, 2)       ! Neighbor points (point number, direction)
        integer :: neiL(2, 2)       ! Neighbor lines  (point number, direction)
                                    ! Point number : 1 - starting, 2 - ending
                                    ! Direction    : 1 - left, 2 - right
        integer :: n_xover          ! The number of scaffold crossovers
        double precision :: t(3, 3) ! Local vector at the center
    end type LineType

! -----------------------------------------------------------------------------

    ! Face type data structure
    type :: FaceType
        integer :: n_poi                ! The number of points
        integer, allocatable :: poi(:)  ! Connectivity
    end type FaceType

! -----------------------------------------------------------------------------

    ! Geometry data type to manage section, point, line and face data
    type :: Geomtype
        integer :: n_sec                    ! The number of sections
        integer :: n_iniP, n_modP, n_croP   ! The number of initial, modified and sectional points
        integer :: n_iniL, n_croL           ! The number of initial, sectional lines
        integer :: n_face                   ! The number of faces
        integer :: min_edge_length
        integer :: max_edge_length

        type(SecType) :: sec                                        ! Section
        type(PointType), allocatable :: iniP(:), modP(:), croP(:)   ! Points
        type(LineType),  allocatable :: iniL(:), croL(:)            ! Lines
        type(FaceType),  allocatable :: face(:)                     ! Face
    end type Geomtype

! -----------------------------------------------------------------------------

end module Data_Geom