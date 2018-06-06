!
! =============================================================================
!
! Module - ModGeo
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
module ModGeo

    use Data_Prob
    use Data_Geom
    use Data_Bound

    use Para
    use List
    use Math

    use Mani

    implicit none

    public  ModGeo_Modification

    private ModGeo_Set_Neighbor_Point
    private ModGeo_Find_Neighbor_Face
    private ModGeo_Find_Neighbor_Point
    private ModGeo_Find_Neighbor_Point_Boundary
    private ModGeo_Get_Point_From_Line
    private ModGeo_Set_Neighbor_Line
    private ModGeo_Find_Neighbor_Line
    private ModGeo_Chimera_Check_Geometry
    private ModGeo_Set_Junction_Data
    private ModGeo_Set_Local_Coorindate
    private ModGeo_Set_Local_Vectors
    private ModGeo_Chimera_Init_Geometry_Local
    private ModGeo_Seperate_Line
    private ModGeo_Find_Scale_Factor
    private ModGeo_Set_Angle_Junction
    private ModGeo_Set_Width_Section
    private ModGeo_Set_Scale_Geometry
    private ModGeo_Set_Gap_Junction
    private ModGeo_Chimera_Mod_Geometry
    private ModGeo_Set_Const_Geometric_Ratio
    private ModGeo_Set_Round_Geometric_Ratio

contains

! -----------------------------------------------------------------------------

! Geometry modification
subroutine ModGeo_Modification(prob, geom, bound)
    type(ProbType),  intent(in)    :: prob
    type(GeomType),  intent(inout) :: geom
    type(BoundType), intent(inout) :: bound

    double precision :: scale
    integer :: i

    ! Print progress
    do i = 0, 11, 11
        write(i, "(a)")
        write(i, "(a)"), "   +--------------------------------------------------------------------+"
        write(i, "(a)"), "   |                                                                    |"
        write(i, "(a)"), "   |                2. Build modified edges and points                  |"
        write(i, "(a)"), "   |                                                                    |"
        write(i, "(a)"), "   +--------------------------------------------------------------------+"
        write(i, "(a)")
    end do

    ! --------------------------------------------------
    ! Set neighbor point and line on each line
    ! --------------------------------------------------
    ! Set neighbor point
    call ModGeo_Set_Neighbor_Point(prob, geom, bound)

    ! Set neighbor line
    call ModGeo_Set_Neighbor_Line(prob, geom, bound)

    ! Write check geometry
    call ModGeo_Chimera_Check_Geometry(prob, geom)

    ! Set arm junction data in the whole structure
    call ModGeo_Set_Junction_Data(geom, bound)

    ! Set local coordinate system on each line
    call ModGeo_Set_Local_Coorindate(geom)

    ! Write initial geometry with local coordinate system
    call ModGeo_Chimera_Init_Geometry_Local(prob, geom)

    ! --------------------------------------------------
    ! Modified geometry construction
    ! --------------------------------------------------
    ! Seperate the edge from the junction
    call ModGeo_Seperate_Line(geom, bound)

    ! --------------------------------------------------
    ! Find scale factor to adjust the size of structure
    ! Pre-calculate the junctional gap and midified edge length
    ! --------------------------------------------------
    scale = ModGeo_Find_Scale_Factor(prob, geom, bound)

    ! Modify the geometic scale with scale factor
    call ModGeo_Set_Scale_Geometry(geom, scale)

    ! Write modified geometry
    !call ModGeo_Chimera_Mod_Geometry(prob, geom, "mod1")

    ! Set the gap distance between the junction and end of edges
    call ModGeo_Set_Gap_Junction(geom, bound)

    ! Set constant modified edge ratio based on original geometry
    if(para_const_edge_mesh == "on"   ) call ModGeo_Set_Const_Geometric_Ratio(geom)
    if(para_const_edge_mesh == "round") call ModGeo_Set_Round_Geometric_Ratio(prob, geom)

    ! Write modified geometry
    call ModGeo_Chimera_Mod_Geometry(prob, geom, "mod2")
end subroutine ModGeo_Modification

! -----------------------------------------------------------------------------

! Set neighbor lines on each line
! For closed geometry, the number of neighbor faces is always two
! For open geometry, the number of neighbor faces at the boundary is always one
subroutine ModGeo_Set_Neighbor_Point(prob, geom, bound)
    type(ProbType),  intent(in)    :: prob
    type(GeomType),  intent(inout) :: geom
    type(BoundType), intent(inout) :: bound

    integer :: point_ref, point_her, point1_com, point2_com
    integer :: i, j, k, m, n, l, nei_face(2), nei_point(2,2)

    ! nei_point(a, b), geom.iniL(i).neiP(a, b)
    ! a - indicates point number
    ! b - indicates left and right (1 - left, 2 - right)

    ! Find neighbor faces and points
    do i = 1, geom.n_iniL

        ! Initialize neighbor face and point data
        nei_face(1:2)     = -1
        nei_point(1, 1:2) = -1
        nei_point(2, 1:2) = -1

        ! Find neighbor face corresponding to line
        nei_face(1:2) = ModGeo_Find_Neighbor_Face(geom, i)

        ! Set nighboring face, 1 - left, 2 - right
        geom.iniL(i).neiF(1) = nei_face(1)
        geom.iniL(i).neiF(2) = nei_face(2)

        ! Determine closed or open geometry and find neighbor point
        if(nei_face(1) /= -1 .and. nei_face(2) /= -1) then

            ! For closed line, find neighbor point from face
            nei_point(:,:) = ModGeo_Find_Neighbor_Point(geom, i, nei_face)

            ! Update
            geom.iniL(i).neiP(1, 1:2) = nei_point(1, 1:2)
            geom.iniL(i).neiP(2, 1:2) = nei_point(2, 1:2)
        else

            if(nei_face(1) == -1 .and. nei_face(2) /= -1 ) then

                nei_point(:,:) = ModGeo_Find_Neighbor_Point_Boundary(geom, i, nei_face(2))

                ! Update
                geom.iniL(i).neiP(1, 1:2) = nei_point(1, 1:2)
                geom.iniL(i).neiP(2, 1:2) = nei_point(2, 1:2)

            else if( nei_face(2) == -1 .and. nei_face(1) /= -1) then

                nei_point(:,:) = ModGeo_Find_Neighbor_Point_Boundary(geom, i, nei_face(1))

                ! Update
                geom.iniL(i).neiP(1, 1:2) = nei_point(1, 1:2)
                geom.iniL(i).neiP(2, 1:2) = nei_point(2, 1:2)

            end if
        end if
    end do

    ! Print progress
    do i = 0, 11, 11
        call Space(i, 6)
        write(i, "(a)"), "2.1. Find neighboring points from initial geometry"
    end do
    do i = 1, geom.n_iniL
        write(11, "(i20, a$ )"), i, " th edge"
        write(11, "(a,   i4$)"), ", (point 1) -> left : ", geom.iniL(i).neiP(1, 1)
        write(11, "(a,   i4$)"), ", right : ",             geom.iniL(i).neiP(1, 2)
        write(11, "(a,   i4$)"), ", (point 2) -> left : ", geom.iniL(i).neiP(2, 1)
        write(11, "(a,   i4 )"), ", right : ",             geom.iniL(i).neiP(2, 2)
    end do
    write(0, "(a)"); write(11, "(a)")
end subroutine ModGeo_Set_Neighbor_Point

! -----------------------------------------------------------------------------

! Find neighbor face corresponding to line
function ModGeo_Find_Neighbor_Face(geom, line) result(nei_face)
    type(GeomType), intent(in) :: geom
    integer,        intent(in) :: line
    
    integer :: nei_face(2), point_1, point_2, point_a, point_b
    integer :: i, j, k, count

    ! nei_face(2) : array for face ID corresponding to id_line
    ! count : closed geometry always has two faces
    count   = 0
    point_1 = geom.iniL(line).poi(1)
    point_2 = geom.iniL(line).poi(2)

    ! Loop for whole faces
    do i = 1, geom.n_face
        do j = 1, geom.face(i).n_poi
            do k = 1, geom.face(i).n_poi

                ! Point by face loop j and k
                point_a = geom.face(i).poi(j)
                point_b = geom.face(i).poi(k)

                ! If both point_1 and point_2
                if(point_a == point_1 .and. point_b == point_2) then

                    ! Increase the number of faces
                    count = count + 1

                    if(count == 1) nei_face(1) = i
                    if(count == 2) nei_face(2) = i
                end if
            end do
        end do
    end do

    ! Check face mesh
    if(nei_face(1) == nei_face(2)) then
        write(0, "(a$)"), "Error - The connection was wrong : "
        write(0, "(a)"),  "ModGeo_Find_Neighbor_Face"
        stop
    end if

    if(count == 0 .or. count > 2) then
        write(0, "(a$)"), "Error - This is not surface mesh : "
        write(0, "(a )"), "ModGeo_Find_Neighbor_Face"
        stop
    end if
end function ModGeo_Find_Neighbor_Face

! -----------------------------------------------------------------------------

! Find neighbor point from face
function ModGeo_Find_Neighbor_Point(geom, line, face) result(nei_point)
    type(GeomType), intent(in) :: geom
    integer,        intent(in) :: line
    integer,        intent(in) :: face(2)

    integer :: nei_point(2,2), i, j, point_1, point_2, num_face, max_point
    integer :: point_a, point_b, point_first, point_last

    point_1 = geom.iniL(line).poi(1)
    point_2 = geom.iniL(line).poi(2)

    do i = 1, 2

        num_face  = face(i)
        max_point = geom.face(num_face).n_poi

        do j = 1, max_point - 1

            point_first = geom.face(num_face).poi(1)
            point_last  = geom.face(num_face).poi(max_point)
            point_a     = geom.face(num_face).poi(j)
            point_b     = geom.face(num_face).poi(j + 1)

            ! If direction of line and face are the same
            if(point_1 == point_a .and. point_2 == point_b) then

                ! Next line is left
                if(j + 1 == max_point) then
                    nei_point(2, 1) = point_first
                else
                    nei_point(2, 1) = geom.face(num_face).poi(j + 2)
                end if

                ! Previous line is left
                if(j == 1) then
                    nei_point(1, 1) = point_last
                else
                    nei_point(1, 1) = geom.face(num_face).poi(j - 1)
                end if

            else if(point_2 == point_first .and. point_1 == point_last) then

                ! At point 2, next line is left
                nei_point(2, 1) = geom.face(num_face).poi(2)

                ! At point 1, previous line is left
                nei_point(1, 1) = geom.face(num_face).poi(max_point - 1)

            end if

            ! If direction of line and face are the opposite
            if(point_2 == point_a .and. point_1 == point_b) then

                ! Previous line is right
                if(j == 1) then
                    nei_point(2, 2) = point_last
                else
                    nei_point(2, 2) = geom.face(num_face).poi(j - 1)
                end if

                ! Next line is left
                if(j + 1 == max_point) then
                    nei_point(1, 2) = point_first
                else
                    nei_point(1, 2) = geom.face(num_face).poi(j + 2)
                end if

            else if(point_1 == point_first .and. point_2 == point_last) then

                ! At point 2, previous line is right
                nei_point(2, 2) = geom.face(num_face).poi(max_point - 1)

                ! At point 1, next line is right
                nei_point(1, 2) = geom.face(num_face).poi(2)

            end if
        end do
    end do
end function ModGeo_Find_Neighbor_Point

! -----------------------------------------------------------------------------

! Find neighbor point from face information at the boundary
function ModGeo_Find_Neighbor_Point_Boundary(geom, line, face) result(nei_point) 
    type(GeomType), intent(in) :: geom
    integer,        intent(in) :: line
    integer,        intent(in) :: face

    integer :: nei_point(2,2), i, j, k, l, count
    integer :: point_num, point_1, point_2, point_a, point_b

    do i = 1, 2

        ! Reference point
        point_num = geom.iniL(line).poi(i)

        ! Loop to find line sharing the points
        do j = 1, geom.n_iniL

            ! If the reference line is identical to comparing line
            if(line == j) cycle

            point_1 = geom.iniL(j).poi(1)
            point_2 = geom.iniL(j).poi(2)

            ! If reference point is the same to the comparing point
            if( point_num == point_1 .or. point_num == point_2 ) then

                ! Find line sharing faces
                do k = 1, geom.face(face).n_poi

                    if(k == geom.face(face).n_poi) then
                        point_a = geom.face(face).poi(k)
                        point_b = geom.face(face).poi(1)
                    else
                        point_a = geom.face(face).poi(k)
                        point_b = geom.face(face).poi(k + 1)
                    end if

                    if( (point_1 == point_a .and. point_2 == point_b) .or. &
                        (point_2 == point_a .and. point_1 == point_b) ) then

                        ! Left neighbor line
                        nei_point(i, 1) = ModGeo_Get_Point_From_Line(geom, line, j)

                    end if

                end do

                ! Find right neighbor line
                !count = 0
            
                ! Find another face sharing jth line
                !do k = 1, geom.n_face
                !    do l = 1, face(k).num_point

                !        if(l == face(k).num_point) then
                !            point_a = face(k, l)
                !            point_b = face(k, 1)
                !        else
                !            point_a = face(k, l)
                !            point_b = face(k, l + 1)
                !        end if

                        ! check whether the points on the jth line are the same to comparing points
                !        if( (point_1 == point_a .and. point_2 == point_b) .or. &
                !            (point_2 == point_a .and. point_1 == point_b) ) then

                !            count = count + 1

                !        end if

                !    end do
                !end do

                ! Right neighbor line
                !if(count == 1) then
                !    nei_point(i, 2) = ModGeo_Get_Point_From_Line(line, line, j)
                !end if

            end if
        end do
    end do
end function ModGeo_Find_Neighbor_Point_Boundary

! -----------------------------------------------------------------------------

! Get opposite point from line
! *-----a-------*------b------** : opint num
! point_num : find point_num from line b that is connected to line a
function ModGeo_Get_Point_From_Line(geom, line_a, line_b)
    type(GeomType), intent(in) :: geom
    integer,        intent(in) :: line_a
    integer,        intent(in) :: line_b

    integer :: ModGeo_Get_Point_From_Line, point_num

    if(geom.iniL(line_a).poi(1) == geom.iniL(line_b).poi(1)) then

        point_num = geom.iniL(line_b).poi(2)

    else if(geom.iniL(line_a).poi(1) == geom.iniL(line_b).poi(2)) then

        point_num = geom.iniL(line_b).poi(1)

    else if(geom.iniL(line_a).poi(2) == geom.iniL(line_b).poi(1)) then

        point_num = geom.iniL(line_b).poi(2)

    else if(geom.iniL(line_a).poi(2) == geom.iniL(line_b).poi(2)) then

        point_num = geom.iniL(line_b).poi(1)

    end if

    ModGeo_Get_Point_From_Line = point_num
end function ModGeo_Get_Point_From_Line

! -----------------------------------------------------------------------------

! Set neighbor lines on each line
! For closed geometry, the number of neighbor faces is always two.
! For open geometry, the number of neighbor faces at the boundary is always one.
subroutine ModGeo_Set_Neighbor_Line(prob, geom, bound)
    type(ProbType),  intent(in)    :: prob
    type(GeomType),  intent(inout) :: geom
    type(BoundType), intent(inout) :: bound

    ! nei_line(a, b)
    ! a : indicates point number
    ! b : indicates left and right (1 - left, 2 - right)
    integer :: i, j, nei_line(2, 2)

    ! Find neighbor line from neighbor point
    do i = 1, geom.n_iniL

        call ModGeo_Find_Neighbor_Line(geom, i, nei_line)

        ! Update
        geom.iniL(i).neiL(1, 1:2) = nei_line(1, 1:2)
        geom.iniL(i).neiL(2, 1:2) = nei_line(2, 1:2)

    end do

    ! Print progress
    do i = 0, 11, 11
        call Space(i, 6)
        write(i, "(a)"), "2.2. Find neighboring edges from initial geometry"
    end do
    do i = 1, geom.n_iniL
        write(11, "(i20, a$ )"), i, " th line"
        write(11, "(a,   i4$)"), ", (point 1) -> left : ", geom.iniL(i).neiL(1, 1)
        write(11, "(a,   i4$)"), ", right : ",             geom.iniL(i).neiL(1, 2)
        write(11, "(a,   i4$)"), ", (point 2) -> left : ", geom.iniL(i).neiL(2, 1)
        write(11, "(a,   i4 )"), ", right : ",             geom.iniL(i).neiL(2, 2)
    end do
    write(0, "(a)"); write(11, "(a)")
end subroutine ModGeo_Set_Neighbor_Line

! -----------------------------------------------------------------------------

! Find neighbor line from neighbor point
subroutine ModGeo_Find_Neighbor_Line(geom, idxL, nei_line)
    type(GeomType), intent(in)  :: geom
    integer,        intent(in)  :: idxL
    integer,        intent(out) :: nei_line(2, 2)

    integer :: j, point_1, point_2

    nei_line(1,1:2) = -1
    nei_line(2,1:2) = -1

    point_1 = geom.iniL(idxL).poi(1)
    point_2 = geom.iniL(idxL).poi(2)

    ! Set neighboring lines
    do j = 1, geom.n_iniL

        if( (geom.iniL(idxL).neiP(1, 1) == geom.iniL(j).poi(1) .and. point_1 == geom.iniL(j).poi(2)) .or. &
            (geom.iniL(idxL).neiP(1, 1) == geom.iniL(j).poi(2) .and. point_1 == geom.iniL(j).poi(1)) ) then
            nei_line(1,1) = j
        end if

        if( (geom.iniL(idxL).neiP(2, 1) == geom.iniL(j).poi(1) .and. point_2 == geom.iniL(j).poi(2)) .or. &
            (geom.iniL(idxL).neiP(2, 1) == geom.iniL(j).poi(2) .and. point_2 == geom.iniL(j).poi(1)) ) then
            nei_line(2,1) = j
        end if

        if( (geom.iniL(idxL).neiP(1, 2) == geom.iniL(j).poi(1) .and. point_1 == geom.iniL(j).poi(2)) .or. &
            (geom.iniL(idxL).neiP(1, 2) == geom.iniL(j).poi(2) .and. point_1 == geom.iniL(j).poi(1)) ) then
            nei_line(1,2) = j
        end if

        if( (geom.iniL(idxL).neiP(2, 2) == geom.iniL(j).poi(1) .and. point_2 == geom.iniL(j).poi(2)) .or. &
            (geom.iniL(idxL).neiP(2, 2) == geom.iniL(j).poi(2) .and. point_2 == geom.iniL(j).poi(1)) ) then
            nei_line(2,2) = j
        end if

    end do
end subroutine ModGeo_Find_Neighbor_Line

! -----------------------------------------------------------------------------

! Write check geometry
subroutine ModGeo_Chimera_Check_Geometry(prob, geom)
    type(ProbType), intent(in) :: prob
    type(GeomType), intent(in) :: geom

    double precision :: pos_1(3), pos_2(3), pos_c(3), pos_c1(3), pos_c2(3)
    double precision :: vec_a(3), vec_b(3), vec(3)
    character(200) :: path
    logical :: f_axis, f_info
    integer :: i, j, point_1, point_2

    if(para_write_301 == .false.) return

    ! Set option
    f_axis = para_chimera_axis
    f_info = para_chimera_301_info

    path = trim(prob.path_work)//"/"//trim(prob.name_file)
    open(unit=301, file=trim(path)//"_check_geo.bild", form="formatted")

    ! Write initial lines
    do i = 1, geom.n_iniL
        point_1    = geom.iniL(i).poi(1)
        point_2    = geom.iniL(i).poi(2)
        pos_1(1:3) = geom.iniP(point_1).pos(1:3)
        pos_2(1:3) = geom.iniP(point_2).pos(1:3)
        pos_c(1:3) = (pos_1(1:3) + pos_2(1:3)) / 2.0d0

        ! Line and orientation vector
        write(301, "(a     )"), ".color dark green"
        write(301, "(a$    )"), ".cylinder "
        write(301, "(3f9.3$)"), pos_1(1:3)
        write(301, "(3f9.3$)"), pos_2(1:3)
        write(301, "(1f9.3 )"), 0.2d0
    end do

    ! Write initial geometric points
    do i = 1, geom.n_iniP
        write(301,"(a     )"), ".color red"
        write(301,"(a$    )"), ".sphere "
        write(301,"(3f9.3$)"), geom.iniP(i).pos(1:3)
        write(301,"(1f9.3 )"), 0.5d0
    end do

    ! Write outward vector
    do i = 1, geom.n_face

        ! Find center position in mesh
        pos_c(1:3) = 0.0d0
        do j = 1, geom.face(i).n_poi
            pos_c(1:3) = pos_c + geom.iniP(geom.face(i).poi(j)).pos
        end do
        pos_c(1:3) = pos_c / dble(geom.face(i).n_poi)

        ! Find orientation
        vec_a(1:3) = geom.iniP(geom.face(i).poi(1)).pos - pos_c
        vec_b(1:3) = geom.iniP(geom.face(i).poi(2)).pos - pos_c
        vec(1:3)   = Normalize(Cross(vec_a, vec_b))

        write(301, "(a     )"), ".color salmon"
        write(301, "(a$    )"), ".arrow "
        write(301, "(3f8.2$)"), pos_c(1:3)
        write(301, "(3f8.2$)"), pos_c(1:3) + 3.0d0*vec(1:3)
        write(301, "(3f8.2 )"), 0.2d0, 0.5d0, 0.6d0
    end do

    ! Write information on line and neighbor numbers
    if (f_info == .true.) then

        ! For lines
        do i = 1, geom.n_iniL
            point_1     = geom.iniL(i).poi(1)
            point_2     = geom.iniL(i).poi(2)
            pos_1(1:3)  = geom.iniP(point_1).pos(1:3)
            pos_2(1:3)  = geom.iniP(point_2).pos(1:3)
            pos_c(1:3)  = (pos_1(1:3) + pos_2(1:3)) / 2.0d0
            vec(1:3)    = Normalize(pos_2(1:3) - pos_1(1:3))
            pos_c2(1:3) = (6.0d0*pos_2 + 4.0d0*pos_1) / (6.0d0 + 4.0d0)
            pos_c1(1:3) = (6.0d0*pos_1 + 4.0d0*pos_2) / (6.0d0 + 4.0d0)

            ! Line number
            write(301, "(a$   )"), ".cmov "
            write(301, "(3f9.3)"), pos_c(1:3) + 0.4d0
            write(301, "(a    )"), ".color blue"
            write(301, "(a    )"), ".font Helvetica 12 bold"
            write(301, "(i7   )"), i

            ! Draw line direction
            write(301, "(a$    )"), ".arrow "
            write(301, "(3f8.2$)"), pos_c(1:3)
            write(301, "(3f8.2$)"), pos_c(1:3) + 1.5d0*vec(1:3)
            write(301, "(2f8.2 )"), 0.25d0, 0.5d0

            ! Neighbor number
            write(301, "(a)"), ".color red"

            ! End and left
            if(geom.iniL(i).neiL(1, 1) /= -1) then
                vec(1:3) = geom.iniP(geom.iniL(i).neiP(1, 1)).pos - pos_c1
                vec(1:3) = Normalize(vec)
                write(301, "(a$   )"), ".cmov "
                write(301, "(3f9.3)"), pos_c1(1:3) + 2.0d0*vec(1:3)
                write(301, "(i7   )"), geom.iniL(i).neiL(1, 1)
            end if

            ! End and right
            if(geom.iniL(i).neiL(1, 2) /= -1) then
                vec(1:3) = geom.iniP(geom.iniL(i).neiP(1, 2)).pos - pos_c1
                vec(1:3) = Normalize(vec)
                write(301, "(a$   )"), ".cmov "
                write(301, "(3f9.3)"), pos_c1(1:3) + 2.0d0*vec(1:3)
                write(301, "(i7   )"), geom.iniL(i).neiL(1, 2)
            end if

            ! Start and left
            if(geom.iniL(i).neiL(2, 1) /= -1) then
                vec(1:3) = geom.iniP(geom.iniL(i).neiP(2, 1)).pos - pos_c2
                vec(1:3) = Normalize(vec)
                write(301, "(a$   )"), ".cmov "
                write(301, "(3f9.3)"), pos_c2(1:3) + 2.0d0*vec(1:3)
                write(301, "(i7   )"), geom.iniL(i).neiL(2, 1)
            end if

            ! Start and right
            if(geom.iniL(i).neiL(2, 2) /= -1) then
                vec(1:3) = geom.iniP(geom.iniL(i).neiP(2, 2)).pos - pos_c2
                vec(1:3) = Normalize(vec)
                write(301, "(a$   )"), ".cmov "
                write(301, "(3f9.3)"), pos_c2(1:3) + 2.0d0*vec(1:3)
                write(301, "(i7   )"), geom.iniL(i).neiL(2, 2)
            end if
        end do

        ! For points
        do i = 1, geom.n_iniP
            write(301, "(a$   )"), ".cmov "
            write(301, "(3f9.3)"), geom.iniP(i).pos(1:3) + 1.0d0
            write(301, "(a    )"), ".color black"
            write(301, "(i7   )"), i
        end do

        ! For faces
        do i = 1, geom.n_face
            pos_c(1:3) = 0.0d0
            do j = 1, geom.face(i).n_poi
                pos_c(1:3) = pos_c + geom.iniP(geom.face(i).poi(j)).pos
            end do
            pos_c(1:3) = pos_c / dble(geom.face(i).n_poi)

            write(301, "(a$   )"), ".cmov "
            write(301, "(3f9.3)"), pos_c(1:3) + 1.0d0
            write(301, "(a    )"), ".color red"
            write(301, "(i7   )"), i
        end do
    end if

    ! Write global axis
    if(f_axis == .true.) then
        write(301, "(a)"), ".translate 0.0 0.0 0.0"
        write(301, "(a)"), ".scale 0.5"
        write(301, "(a)"), ".color grey"
        write(301, "(a)"), ".sphere 0 0 0 0.5"      ! Center
        write(301, "(a)"), ".color red"             ! x-axis
        write(301, "(a)"), ".arrow 0 0 0 4 0 0 "
        write(301, "(a)"), ".color blue"            ! y-axis
        write(301, "(a)"), ".arrow 0 0 0 0 4 0 "
        write(301, "(a)"), ".color yellow"          ! z-axis
        write(301, "(a)"), ".arrow 0 0 0 0 0 4 "
    end if

    close(unit=301)
end subroutine ModGeo_Chimera_Check_Geometry

! -----------------------------------------------------------------------------

! Set arm junction data in the whole strcutre
subroutine ModGeo_Set_Junction_Data(geom, bound)
    type(GeomType),  intent(inout) :: geom
    type(BoundType), intent(inout) :: bound

    type(ListJunc), pointer :: junc, ptr
    integer :: i, j, k, count, poi_cur, poi_com

    ! Nullify linked list for junction data
    nullify(junc)
    nullify(ptr)

    ! --------------------------------------------------
    ! Find junctions and allocate linked list
    ! --------------------------------------------------
    do i = 1, geom.n_iniP

        count   = 0
        poi_cur = i

        ! Allocate ptr linked list
        allocate(ptr)

        ! Loop for comparing line
        do j = 1, geom.n_iniL
            do k = 1, 2

                poi_com = geom.iniL(j).poi(k)
                if(poi_cur == poi_com) then
                    count          = count + 1
                    ptr%n_arm      = count
                    ptr%cnL(count) = j
                    ptr%poi_c      = poi_cur
                end if
            end do
        end do

        ! If junction is connected to more than 2 arms
        if(count >= 2) then
            junc => List_Insert_Junc(junc, ptr)
        else
            write(0, "(a$)"), "Error - Not closed geometry : "
            write(0, "(a )"), "ModGeo_Set_Junction_Data"
            stop
        end if
    end do

    ! Allocate global junc data structure
    bound.n_junc = List_Count_Junc(junc)
    allocate(bound.junc(bound.n_junc))

    ! Copy from linked list to global vector
    ptr => junc
    do i = 1, bound.n_junc

        bound.junc(bound.n_junc-i+1).n_arm = ptr%n_arm
        bound.junc(bound.n_junc-i+1).poi_c = ptr%poi_c

        allocate(bound.junc(bound.n_junc-i+1).iniL(ptr%n_arm))
        allocate(bound.junc(bound.n_junc-i+1).modP(ptr%n_arm))
        allocate(bound.junc(bound.n_junc-i+1).croP(ptr%n_arm, geom.n_sec))
        allocate(bound.junc(bound.n_junc-i+1).node(ptr%n_arm, geom.n_sec))
        allocate(bound.junc(bound.n_junc-i+1).conn(ptr%n_arm*geom.n_sec, 2))
        allocate(bound.junc(bound.n_junc-i+1).type_conn(ptr%n_arm*geom.n_sec))

        do j = 1, ptr%n_arm
            bound.junc(bound.n_junc-i+1).iniL(j)    = ptr%cnL(j)    ! Initial line
            bound.junc(bound.n_junc-i+1).modP(j)    = -1            ! Modified point
            bound.junc(bound.n_junc-i+1).croP(j, :) = -1            ! Sectional point
            bound.junc(bound.n_junc-i+1).node(j, :) = -1            ! Node
        end do

        do j = 1, geom.n_sec*ptr%n_arm
            bound.junc(bound.n_junc-i+1).conn(j, :)   = -1      ! Sectional connection
            bound.junc(bound.n_junc-i+1).type_conn(j) = -1      ! Type of sectional connection
        end do

        ptr => ptr%next
    end do

    ! Delete linked list allocated
    call List_Delete_Junc(junc)
    !call List_Delete_Junc(ptr)

    ! Print progress
    do i = 0, 11, 11
        call Space(i, 6)
        write(i, "(a)"), "2.3. Construct arm junction data"
    end do
    do i = 1, bound.n_junc
        ! 1 th junction : 3-arms -> center point # 1, lines # : (1, 2, 3)
        write(11, "(i20, a$)"), i, " th junc : "
        write(11, "(i4,  a$)"), bound.junc(i).n_arm, "-arms -> center point # : "
        write(11, "(i4,  a$)"), bound.junc(i).poi_c, ", lines # : ("
        do j = 1, bound.junc(i).n_arm - 1
            write(11, "(i4, a$)"), bound.junc(i).iniL(j), ", "
        end do
        write(11, "(i4, a)"), bound.junc(i).iniL(bound.junc(i).n_arm), ")"
    end do
    write(0, "(a)"); write(11, "(a)")
end subroutine ModGeo_Set_Junction_Data

! -----------------------------------------------------------------------------

! Set local coordinate system on initial geometry
subroutine ModGeo_Set_Local_Coorindate(geom)
    type(GeomType), intent(inout) :: geom

    integer :: i

    ! Print progress
    do i = 0, 11, 11
        call Space(i, 6)
        write(i, "(a)"), "2.4. Set local coordinate system on initial edges"
    end do

    ! Set local vecotrs on each line
    do i = 1, geom.n_iniL

        ! Set local coordinate vecotrs
        geom.iniL(i).t(:,:) = ModGeo_Set_Local_Vectors(geom, i)

        ! Print detailed information
        ! 1 th line : t1 -> [**, **, **], t2 -> [**, **, **], t3 -> [**, **, **]
        write(11, "(i20,  a$)"), i, " th line : t1 -> [ "
        write(11, "(f5.2, a$)"), geom.iniL(i).t(1, 1), ", "
        write(11, "(f5.2, a$)"), geom.iniL(i).t(1, 2), ", "
        write(11, "(f5.2, a$)"), geom.iniL(i).t(1, 3), " ], t2 -> [ "
        write(11, "(f5.2, a$)"), geom.iniL(i).t(2, 1), ", "
        write(11, "(f5.2, a$)"), geom.iniL(i).t(2, 2), ", "
        write(11, "(f5.2, a$)"), geom.iniL(i).t(2, 3), " ], t3 -> [ "
        write(11, "(f5.2, a$)"), geom.iniL(i).t(3, 1), ", "
        write(11, "(f5.2, a$)"), geom.iniL(i).t(3, 2), ", "
        write(11, "(f5.2, a )"), geom.iniL(i).t(3, 3), " ]"
    end do
    write(0, "(a)"); write(11, "(a)")
end subroutine ModGeo_Set_Local_Coorindate

! -----------------------------------------------------------------------------

! Set local vecotrs on initial geometry
function ModGeo_Set_Local_Vectors_Old(geom, line, point) result(local)
    type(GeomType), intent(in) :: geom
    integer,        intent(in) :: line
    integer,        intent(in) :: point

    double precision :: local(3,3), pos_1(3), pos_2(3), vec_l(3), vec_r(3)
    double precision :: vec(3), vec_n(3), vec_jn(3), vec_jt(3)
    integer :: i, point_1, point_2, point_cur

    ! Find first local vector, t1
    point_1    = geom.iniL(line).poi(1)
    point_2    = geom.iniL(line).poi(2)
    pos_1(1:3) = geom.iniP(point_1).pos(1:3)
    pos_2(1:3) = geom.iniP(point_2).pos(1:3)
    local(1,:) = Normalize(pos_2 - pos_1)

    ! Find third local vector, t3
    point_cur  = geom.iniL(line).poi(point)
    vec_l(1:3) = geom.iniP(geom.iniL(line).neiP(point, 1)).pos - geom.iniP(point_cur).pos
    vec_r(1:3) = geom.iniP(geom.iniL(line).neiP(point, 2)).pos - geom.iniP(point_cur).pos
    vec(1:3)   = Normalize(vec_r - vec_l)

    ! Vector projection
    vec_n(1:3)  = Normalize(pos_1 - pos_2)
    vec_jn(1:3) = dot_product(vec, vec_n) * vec_n
    vec_jt(1:3) = Normalize(vec - vec_jn)
    local(3,:)  = vec_jt(1:3)

    ! Find second local vector t2
    local(2,:) = Cross(local(3,:), local(1,:))
    local(2,:) = Normalize(local(2,:))

    ! Check local vector
    if(dabs(Norm(local(1, 1:3)) - 1.0d0) > eps) then
        write(0, "(a$)"), "Error - The t1 local vector was not defined : "
        write(0, "(a$)"), "ModGeo_Set_Local_Vectors_Old"
        stop
    else if(dabs(Norm(local(2, 1:3)) - 1.0d0) > eps) then
        write(0, "(a$)"), "Error - The t2 local vector was not defined : "
        write(0, "(a$)"), "ModGeo_Set_Local_Vectors_Old"
        stop
    else if(dabs(Norm(local(3, 1:3)) - 1.0d0) > eps) then
        write(0, "(a$)"), "Error - The t3 local vector was not defined : "
        write(0, "(a$)"), "ModGeo_Set_Local_Vectors_Old"
        stop
    end if
end function ModGeo_Set_Local_Vectors_Old

! -----------------------------------------------------------------------------

! Set local vecotrs on initial geometry
function ModGeo_Set_Local_Vectors(geom, line) result(local)
    type(GeomType), intent(in) :: geom
    integer,        intent(in) :: line

    double precision :: local(3,3), pos_1(3), pos_2(3), vec_face1(3), vec_face2(3)
    double precision :: vec_a(3), vec_b(3), pos_c(3)
    integer :: i, point_1, point_2, face1, face2

    ! Find first local vector, t1
    point_1    = geom.iniL(line).poi(1)
    point_2    = geom.iniL(line).poi(2)
    pos_1(1:3) = geom.iniP(point_1).pos(1:3)
    pos_2(1:3) = geom.iniP(point_2).pos(1:3)
    local(1,:) = Normalize(pos_2 - pos_1)

    ! Find second local vector, t2
    face1 = geom.iniL(line).neiF(1)
    face2 = geom.iniL(line).neiF(2)

    ! Find center position in face 1
    pos_c(1:3) = 0.0d0
    do i = 1, geom.face(face1).n_poi
        pos_c(1:3) = pos_c + geom.iniP(geom.face(face1).poi(i)).pos
    end do
    pos_c(1:3) = pos_c / dble(geom.face(face1).n_poi)

    ! Find normal vector in face 1
    vec_a(1:3) = geom.iniP(geom.face(face1).poi(1)).pos - pos_c
    vec_b(1:3) = geom.iniP(geom.face(face1).poi(2)).pos - pos_c
    vec_face1(1:3) = Normalize(Cross(vec_a, vec_b))

    ! Find center position in face 2
    pos_c(1:3) = 0.0d0
    do i = 1, geom.face(face2).n_poi
        pos_c(1:3) = pos_c + geom.iniP(geom.face(face2).poi(i)).pos
    end do
    pos_c(1:3) = pos_c / dble(geom.face(face2).n_poi)

    ! Find normal vector in face 2
    vec_a(1:3) = geom.iniP(geom.face(face2).poi(1)).pos - pos_c
    vec_b(1:3) = geom.iniP(geom.face(face2).poi(2)).pos - pos_c
    vec_face2(1:3) = Normalize(Cross(vec_a, vec_b))

    ! Set second local vector
    local(2,:) = 0.5d0 * (vec_face1 + vec_face2)
    local(2,:) = Normalize(local(2,:))

    ! Find second local vector t3
    local(3,:) = Cross(local(1,:), local(2,:))
    local(3,:) = Normalize(local(3,:))

    ! Check local vector
    if(dabs(Norm(local(1, 1:3)) - 1.0d0) > eps) then
        write(0, "(a$)"), "Error - The t1 local vector was not defined : "
        write(0, "(a$)"), "ModGeo_Set_Local_Vectors"
        stop
    else if(dabs(Norm(local(2, 1:3)) - 1.0d0) > eps) then
        write(0, "(a$)"), "Error - The t2 local vector was not defined : "
        write(0, "(a$)"), "ModGeo_Set_Local_Vectors"
        stop
    else if(dabs(Norm(local(3, 1:3)) - 1.0d0) > eps) then
        write(0, "(a$)"), "Error - The t3 local vector was not defined : "
        write(0, "(a$)"), "ModGeo_Set_Local_Vectors"
        stop
    end if
end function ModGeo_Set_Local_Vectors

! -----------------------------------------------------------------------------

! Write initial geometry with local coordinate system
subroutine ModGeo_Chimera_Init_Geometry_Local(prob, geom)
    type(ProbType), intent(in) :: prob
    type(GeomType), intent(in) :: geom

    double precision :: length, pos_1(3), pos_2(3), pos_c(3), local(3, 3)
    character(200) :: path
    logical :: f_axis, f_info
    integer :: i

    if(para_write_302 == .false.) return

    ! Set option
    f_axis = para_chimera_axis
    f_info = para_chimera_302_info

    path = trim(prob.path_work)//"/"//trim(prob.name_file)
    open(unit=302, file=trim(path)//"_02_target_geometry_local.bild", form="formatted")

    ! Write modified lines
    write(302, "(a)"), ".color dark green"
    do i = 1, geom.n_iniL
        pos_1(1:3) = geom.iniP(geom.iniL(i).poi(1)).pos
        pos_2(1:3) = geom.iniP(geom.iniL(i).poi(2)).pos
        write(302, "(a$    )"), ".cylinder "
        write(302, "(3f9.3$)"), pos_1(1:3)
        write(302, "(3f9.3$)"), pos_2(1:3)
        write(302, "(1f9.3 )"), 0.2d0
    end do

    ! Write modified points
    write(302, "(a)"), ".color red"
    do i = 1, geom.n_iniP
        write(302, "(a$    )"), ".sphere "
        write(302, "(3f9.3$)"), geom.iniP(i).pos(1:3)
        write(302, "(1f9.3 )"), 0.5d0
    end do

    ! Information on indeces of the lines and points
    if(f_info == .true.) then

        ! For edges
        do i = 1, geom.n_iniL
            pos_1(1:3) = geom.iniP(geom.iniL(i).poi(1)).pos
            pos_2(1:3) = geom.iniP(geom.iniL(i).poi(2)).pos
            pos_c(1:3) = (pos_1(1:3) + pos_2(1:3)) / 2.0d0

            write(302, "(a$   )"), ".cmov "
            write(302, "(3f9.3)"), pos_c(1:3) + 0.4d0
            write(302, "(a    )"), ".color black"
            write(302, "(a    )"), ".font Helvetica 12 bold"
            write(302, "(i7   )"), i
        end do

        ! For points
        do i = 1, geom.n_iniP
            write(302, "(a$   )"), ".cmov "
            write(302, "(3f9.3)"), geom.iniP(i).pos(1:3) + 0.4d0
            write(302, "(a    )"), ".color red"
            write(302, "(a    )"), ".font Helvetica 12 bold"
            write(302, "(i7   )"), i
        end do

    end if

    do i = 1, geom.n_iniL
        pos_1(1:3) = geom.iniP(geom.iniL(i).poi(1)).pos
        pos_2(1:3) = geom.iniP(geom.iniL(i).poi(2)).pos
        pos_c(1:3) = (pos_1(1:3) + pos_2(1:3)) / 2.0d0

        ! Local vectors
        local(1, 1:3) = geom.iniL(i).t(1,:)
        local(2, 1:3) = geom.iniL(i).t(2,:)
        local(3, 1:3) = geom.iniL(i).t(3,:)

        write(302, "(a     )"), ".color red"     ! x-axis
        write(302, "(a$    )"), ".arrow "
        write(302, "(3f8.2$)"), pos_c(1:3)
        write(302, "(3f8.2$)"), pos_c + local(1,:) * 1.8d0
        write(302, "(3f8.2 )"), 0.22d0, 0.44d0, 0.6d0

        write(302, "(a     )"), ".color blue"    ! y-axis
        write(302, "(a$    )"), ".arrow "
        write(302, "(3f8.2$)"), pos_c(1:3)
        write(302, "(3f8.2$)"), pos_c + local(2,:) * 1.8d0
        write(302, "(3f8.2 )"), 0.2d0, 0.4d0, 0.6d0

        write(302, "(a     )"), ".color yellow"  ! z-axis
        write(302, "(a$    )"), ".arrow "
        write(302, "(3f8.2$)"), pos_c(1:3)
        write(302, "(3f8.2$)"), pos_c + local(3,:) * 1.8d0
        write(302, "(3f8.2 )"), 0.2d0, 0.4d0, 0.6d0
    end do

    ! Write global axis
    if(f_axis == .true.) then
        write(302, "(a)"), ".translate 0.0 0.0 0.0"
        write(302, "(a)"), ".scale 0.5"
        write(302, "(a)"), ".color grey"
        write(302, "(a)"), ".sphere 0 0 0 0.5"      ! Center
        write(302, "(a)"), ".color red"             ! x-axis
        write(302, "(a)"), ".arrow 0 0 0 4 0 0 "
        write(302, "(a)"), ".color blue"            ! y-axis
        write(302, "(a)"), ".arrow 0 0 0 0 4 0 "
        write(302, "(a)"), ".color yellow"          ! z-axis
        write(302, "(a)"), ".arrow 0 0 0 0 0 4 "
    end if
    close(unit=302)

    ! ---------------------------------------------
    !
    ! Write the file for Tecplot
    !
    ! ---------------------------------------------
    if(para_output_Tecplot == "off") return

    path = trim(prob.path_work)//"/tecplot\"//trim(prob.name_file)
    open(unit=302, file=trim(path)//"_02_target_geometry_local.dat", form="formatted")

    write(302, "(a )"), 'TITLE = "'//trim(prob.name_file)//'"'
    write(302, "(a )"), 'VARIABLES = "X", "Y", "Z", "t1", "t2", "t3"'
    write(302, "(a$)"), 'ZONE F = FEPOINT'
    write(302, "(a$)"), ', N='//trim(adjustl(Int2Str(geom.n_iniP)))
    write(302, "(a$)"), ', E='//trim(adjustl(Int2Str(geom.n_iniL)))
    write(302, "(a )"), ', ET=LINESEG'

    ! Write vertices
    do i = 1, geom.n_iniP
        write(302, "(3f9.3$)"), geom.iniP(i).pos(1:3)
        write(302, "(3f9.3 )"), 1.0d0, 1.0d0, 1.0d0
    end do

    ! Write edges
    do i = 1, geom.n_iniL
        write(302, "(2i7)"), geom.iniL(i).poi(1), geom.iniL(i).poi(2)
    end do

    write(302, "(a )"), 'VARIABLES = "X", "Y", "Z", "t1", "t2", "t3"'
    write(302, "(a$)"), 'ZONE F = FEPOINT'
    write(302, "(a$)"), ', N='//trim(adjustl(Int2Str(geom.n_iniL)))
    write(302, "(a$)"), ', E='//trim(adjustl(Int2Str(geom.n_iniL)))
    write(302, "(a )"), ', ET=LINESEG'

    ! Local coordinate system on edges
    do i = 1, geom.n_iniL
        pos_1(1:3) = geom.iniP(geom.iniL(i).poi(1)).pos(1:3)
        pos_2(1:3) = geom.iniP(geom.iniL(i).poi(2)).pos(1:3)
        pos_c(1:3) = (pos_1(1:3) + pos_2(1:3)) / 2.0d0

        write(302, "(3f9.3$)"), pos_c(1:3)
        write(302, "(3f9.3 )"), geom.iniL(i).t(1, 1:3)
    end do

    ! Write edges
    do i = 1, geom.n_iniL
        write(302, "(2i7)"), i, i
    end do

    write(302, "(a )"), 'VARIABLES = "X", "Y", "Z", "t1", "t2", "t3"'
    write(302, "(a$)"), 'ZONE F = FEPOINT'
    write(302, "(a$)"), ', N='//trim(adjustl(Int2Str(geom.n_iniL)))
    write(302, "(a$)"), ', E='//trim(adjustl(Int2Str(geom.n_iniL)))
    write(302, "(a )"), ', ET=LINESEG'

    ! Local coordinate system on edges
    do i = 1, geom.n_iniL
        pos_1(1:3) = geom.iniP(geom.iniL(i).poi(1)).pos(1:3)
        pos_2(1:3) = geom.iniP(geom.iniL(i).poi(2)).pos(1:3)
        pos_c(1:3) = (pos_1(1:3) + pos_2(1:3)) / 2.0d0

        write(302, "(3f9.3$)"), pos_c(1:3)
        write(302, "(3f9.3 )"), geom.iniL(i).t(2, 1:3)
    end do

    ! Write edges
    do i = 1, geom.n_iniL
        write(302, "(2i7)"), i, i
    end do

    write(302, "(a )"), 'VARIABLES = "X", "Y", "Z", "t1", "t2", "t3"'
    write(302, "(a$)"), 'ZONE F = FEPOINT'
    write(302, "(a$)"), ', N='//trim(adjustl(Int2Str(geom.n_iniL)))
    write(302, "(a$)"), ', E='//trim(adjustl(Int2Str(geom.n_iniL)))
    write(302, "(a )"), ', ET=LINESEG'

    ! Local coordinate system on edges
    do i = 1, geom.n_iniL
        pos_1(1:3) = geom.iniP(geom.iniL(i).poi(1)).pos(1:3)
        pos_2(1:3) = geom.iniP(geom.iniL(i).poi(2)).pos(1:3)
        pos_c(1:3) = (pos_1(1:3) + pos_2(1:3)) / 2.0d0

        write(302, "(3f9.3$)"), pos_c(1:3)
        write(302, "(3f9.3 )"), geom.iniL(i).t(3, 1:3)
    end do

    ! Write edges
    do i = 1, geom.n_iniL
        write(302, "(2i7)"), i, i
    end do

    close(unit=302)
end subroutine ModGeo_Chimera_Init_Geometry_Local

! -----------------------------------------------------------------------------

! Seperate the edge from the junction, modified geometry
subroutine ModGeo_Seperate_Line(geom, bound)
    type(GeomType),  intent(inout) :: geom
    type(BoundType), intent(inout) :: bound

    integer, allocatable :: count_arm(:)
    integer :: i, j, poi_1, poi_2, poi_c

    ! Print progress
    do i = 0, 11, 11
        call Space(i, 6)
        write(i, "(a)"), "2.5. Seperate edges from the vertex (modified edges)"
        call Space(i, 11)
        write(i, "(a)"), "* The number of initial points  : "//trim(adjustl(Int2Str(geom.n_iniP)))
        call Space(i, 11)
        write(i, "(a)"), "* The number of initial edges   : "//trim(adjustl(Int2Str(geom.n_iniL)))
        call Space(i, 11)
        write(i, "(a)"), "* The number of modified points : "//trim(adjustl(Int2Str(2*geom.n_iniL)))
        call Space(i, 11)
        write(i, "(a)"), "* The number of modified edges  : "//trim(adjustl(Int2Str(geom.n_iniL)))
        write(i, "(a)")
    end do

    ! Check edge length
    !do i = 1, geom.n_iniL
    !    poi_1  = geom.iniL(i).poi(1)
    !    poi_2  = geom.iniL(i).poi(2)
    !    print *, Norm(geom.iniP(poi_1).pos - geom.iniP(poi_2).pos)
    !end do

    ! Reset the number of the points
    ! The number of lines in modfied geometry are the same to initial one
    geom.n_modP = 2 * geom.n_iniL
    geom.n_iniL = geom.n_iniL

    ! Reallocate global point data
    allocate(geom.modP(geom.n_modP))

    ! Initialize the number of the arm junctions
    allocate(count_arm(bound.n_junc))
    count_arm(1:bound.n_junc) = 0

    ! Set point connectivity from line number
    do i = 1, geom.n_iniL

        ! Point of initial line
        poi_1 = geom.iniL(i).poi(1)
        poi_2 = geom.iniL(i).poi(2)

        ! Set position vector for new points
        geom.modP(2*i-1).pos(1:3) = geom.iniP(poi_1).pos(1:3)
        geom.modP(2*i-0).pos(1:3) = geom.iniP(poi_2).pos(1:3)

        ! Set connectivity for new points
        geom.iniL(i).poi(1) = 2 * i - 1
        geom.iniL(i).poi(2) = 2 * i

        ! Update modified points in the junction data
        do j = 1, bound.n_junc

            ! Center point of junction
            poi_c = bound.junc(j).poi_c

            if(poi_1 == poi_c) then
                count_arm(j) = count_arm(j) + 1
                bound.junc(j).modP(count_arm(j)) = geom.iniL(i).poi(1)
            else if(poi_2 == poi_c) then
                count_arm(j) = count_arm(j) + 1
                bound.junc(j).modP(count_arm(j)) = geom.iniL(i).poi(2)
            end if
        end do
    end do

    ! Check edge length
    !do i = 1, geom.n_iniL
    !    poi_1  = geom.iniL(i).poi(1)
    !    poi_2  = geom.iniL(i).poi(2)
    !    print *, Norm(geom.modP(poi_1).pos - geom.modP(poi_2).pos)
    !end do

    ! Deallocation
    deallocate(count_arm)

    ! Print progress
    do i = 0, 11, 11
        call Space(i, 6)
        write(i, "(a)"), "2.6. Update junction data with modified points"
    end do

    do i = 1, bound.n_junc
        ! 1 th junction : 3-arms -> mod points # : (1, 2, 3)
        write(11, "(i20, a$)"), i, " th junc : "
        write(11, "(i4,  a$)"), bound.junc(i).n_arm, "-arms -> mod points # : ("
        do j = 1, bound.junc(i).n_arm - 1
            write(11, "(i4, a$)"), bound.junc(i).modP(j), ", "
        end do
        write(11, "(i4, a)"), bound.junc(i).modP(j), ")"
    end do

    write(0, "(a)"); write(11, "(a)")
end subroutine ModGeo_Seperate_Line

! -----------------------------------------------------------------------------

! Find scale factor and junctional angle to adjust the size of structure
! Pre-calculate the junctional gap and midified edge length
function ModGeo_Find_Scale_Factor(prob, geom, bound) result(scale)
    type(ProbType),  intent(in)    :: prob
    type(GeomType),  intent(inout) :: geom
    type(BoundType), intent(inout) :: bound

    double precision, allocatable, dimension (:,:) :: pos_modP
    double precision :: tot_ang, ref_ang, ang, width, dist_gap
    double precision :: factor, scale, length, min_length, diff, mod_length
    double precision :: pos_cur(3), pos_opp(3), vec_a(3), vec_b(3)
    integer :: i, j, poi_cur, poi_1, poi_2

    ! Scale up to adjust modified edges
    call ModGeo_Set_Scale_Geometry(geom, 100.0d0/para_init_scale)

    ! Allocate original and modified point position
    allocate(pos_modP(geom.n_modP, 3))

    ! Set angle junction between neighboring edges at the junction
    call ModGeo_Set_Angle_Junction(geom, bound)

    ! Set width of cross-section
    width = ModGeo_Set_Width_Section(geom)

    ! Loop for junction to pre-calculate the length of the modified edges
    bound.max_gap = bound.junc(1).gap
    bound.min_gap = bound.junc(1).gap
    do i = 1, bound.n_junc

        ! Find reference and total angle
        ref_ang = bound.junc(i).ref_ang
        tot_ang = bound.junc(i).tot_ang

        ang = ref_ang*(2.0d0*pi/tot_ang)

        ! 0.2    -------- 60
        ! factor -------- ang-ref_ang
        ! 0.0    -------- 0
        if(geom.sec.n_col == 2) then
            factor = (0.20d0-0.0d0)*(ang-ref_ang)/Deg2Rad(60.0d0) + 0.0d0
        else
            factor = 0.0d0
        end if

        !write(0, "(4(a, f10.3))"), "ang : ", Rad2Deg(ang), ", ref_ang  : ", Rad2Deg(ref_ang), &
        !    ", tot_ang : ",  Rad2Deg(tot_ang), ", factor : ", factor

        if(tot_ang <= 2.0d0*pi) then
            dist_gap = width/2.0d0/dtan(ang/2.0d0) * (2.0d0*pi/tot_ang)
            dist_gap = (width/2.0d0/dtan(ang/2.0d0) + factor) * (ang/ref_ang)

            ! Find the apothem of a regular polygon at the junction
            ! a = 0.5*s/tan(180/n), https://en.wikipedia.org/wiki/Apothem
            ! The apothem a of a regular n-sided polygon with side length s
            !dist_gap = (0.5d0 * width / dtan(pi/dble(bound.junc(i).n_arm))+factor) * (ang/ref_ang)
        else
            dist_gap = width/2.0d0/dtan(ang/2.0d0)
        end if

        bound.junc(i).gap = dist_gap
        if(bound.max_gap <= dist_gap) bound.max_gap = dist_gap
        if(bound.min_gap >= dist_gap) bound.min_gap = dist_gap

        ! Find modified position at the given initial scale
        do j = 1, bound.junc(i).n_arm

            ! Position vector of arm junction point
            poi_cur = bound.junc(i).modP(j)
            pos_cur = geom.modP(poi_cur).pos(1:3)

            poi_1 = geom.iniL(bound.junc(i).iniL(j)).poi(1)
            poi_2 = geom.iniL(bound.junc(i).iniL(j)).poi(2)

            ! Find point that is opposite to point_ori
            if(poi_1 == poi_cur) then
                pos_opp(1:3) = geom.modP(poi_2).pos(1:3)
            else if(poi_2 == poi_cur) then
                pos_opp(1:3) = geom.modP(poi_1).pos(1:3)
            end if

            ! Original edge length
            length = Norm(pos_opp(1:3) - pos_cur(1:3))

            ! Find modified position vector
            vec_a(1:3) = dist_gap*pos_opp(1:3)
            vec_b(1:3) = (length-dist_gap)*pos_cur(1:3)
            pos_modP(poi_cur, 1:3) = (vec_a + vec_b)/length
        end do
    end do

    ! Find minimum difference length
    do i = 1, geom.n_iniL

        ! Find point
        poi_1 = geom.iniL(i).poi(1)
        poi_2 = geom.iniL(i).poi(2)

        ! Find difference length between original and modified edges
        ! Length of modified edge
        length = Norm(pos_modP(poi_1,:) - pos_modP(poi_2,:))

        ! Find minimum length of modified edge
        if(i == 1 .or. min_length > length) then
            min_length = length
            mod_length = Norm(geom.modP(poi_1).pos - geom.modP(poi_2).pos)
            diff       = mod_length - min_length
            !write(0, "(i, 2f)"), i, mod_length, min_length
        end if
    end do

    ! Desired length
    if(geom.sec.types == "square") then
        length = diff + para_dist_bp * (dble(prob.n_bp_edge-1))
    else if(geom.sec.types == "honeycomb") then
        length = diff + para_dist_bp * (dble(prob.n_bp_edge-1-1))
    end if
    scale = length / mod_length

    ! Print progress
    do i = 0, 11, 11
        call Space(i, 6)
        write(i, "(a)"), "2.7. Find the scale factor to adjust polyhedra size"
        call Space(i, 11)
        write(i, "(a)"), "* The minumum edge length       : "//trim(adjustl(Int2Str(prob.n_bp_edge)))
        call Space(i, 11)
        write(i, "(a)"), "* Scale factor to adjust size   : "//trim(adjustl(Dble2Str(scale)))
        write(i, "(a)")
    end do

    ! Deallocate
    deallocate(pos_modP)
end function ModGeo_Find_Scale_Factor

! -----------------------------------------------------------------------------

! Set angle junction between neighboring edges at the junction
subroutine ModGeo_Set_Angle_Junction(geom, bound)
    type(GeomType),  intent(in)    :: geom
    type(BoundType), intent(inout) :: bound

    type :: JuncType
        integer :: n_arm    ! The number of arms
        double precision, allocatable :: ang(:)
    end type JuncType

    type(JuncType), allocatable :: junc(:)
    double precision :: pos_center(3), pos_pre(3), pos_next(3)
    double precision :: tot_ang, ref_ang, max_ang, min_ang, ang
    double precision :: vec_1(3), vec_2(3)
    integer :: i, j, point, point_c

    ! Allocate junc angle memory
    allocate(junc(bound.n_junc))
    do i = 1, bound.n_junc
        junc(i).n_arm = bound.junc(i).n_arm
        allocate(junc(i).ang(junc(i).n_arm))
        junc(i).n_arm = 0
    end do

    ! Find angle at the junction
    do i = 1, geom.n_face
        do j = 1, geom.face(i).n_poi

            ! Find center position
            point_c = geom.face(i).poi(j)
            pos_center(:) = geom.iniP(point_c).pos(1:3)

            ! Find previous position
            if(j == 1) then
                point = geom.face(i).poi(geom.face(i).n_poi)
                pos_pre(1:3) = geom.iniP(point).pos(1:3)
            else
                point = geom.face(i).poi(j-1)
                pos_pre(1:3) = geom.iniP(point).pos(1:3)
            end if

            ! Find next position
            if(j == geom.face(i).n_poi) then
                point = geom.face(i).poi(1)
                pos_next(1:3) = geom.iniP(point).pos(1:3)
            else
                point = geom.face(i).poi(j+1)
                pos_next(1:3) = geom.iniP(point).pos(1:3)
            end if

            vec_1(1:3) = pos_pre(1:3)  - pos_center(1:3)
            vec_2(1:3) = pos_next(1:3) - pos_center(1:3)

            ! Find angle between two vectors in 3D
            ang = datan2(Norm(Cross(vec_1, vec_2)), dot_product(vec_1, vec_2))

            junc(point_c).n_arm = junc(point_c).n_arm + 1
            junc(point_c).ang(junc(point_c).n_arm) = ang
        end do
    end do

    ! Set maximum and minimum angle at the junction
    do i = 1, bound.n_junc

        tot_ang = 0.0d0
        max_ang = junc(i).ang(1)
        min_ang = junc(i).ang(1)

        do j = 1, junc(i).n_arm
            tot_ang = tot_ang + junc(i).ang(j)
        end do

        do j = 2, junc(i).n_arm
            if(max_ang < junc(i).ang(j)) max_ang = junc(i).ang(j)
            if(min_ang > junc(i).ang(j)) min_ang = junc(i).ang(j)
        end do

        ! Set reference and total angle at the junction
        if(para_junc_ang == "min" .or. para_junc_ang == "opt") then
            bound.junc(i).ref_ang = min_ang
        else if(para_junc_ang == "max") then
            bound.junc(i).ref_ang = max_ang
        else if(para_junc_ang == "ave") then
            bound.junc(i).ref_ang = tot_ang / dble(junc(i).n_arm)
        end if

        bound.junc(i).tot_ang = tot_ang
    end do

    ! deallocate memory
    do i = 1, bound.n_junc
        deallocate(junc(i).ang)
    end do

    deallocate(junc)
end subroutine ModGeo_Set_Angle_Junction

! -----------------------------------------------------------------------------

! Find width cross-section
function ModGeo_Set_Width_Section(geom) result(width)
    type(GeomType), intent(in) :: geom

    double precision :: width
    integer :: n_column

    ! Find the number of columns in terms of reference row
    if(geom.sec.types == "square") then
        n_column = geom.sec.ref_maxC - geom.sec.ref_minC + 1
    else if(geom.sec.types == "honeycomb") then
        if(geom.sec.ref_row == 1) then
            n_column = 2
        else
            ! 2 -> 3*1, 4 -> 3*2, 6 -> 3*3
            n_column = 3 * (geom.sec.ref_maxC - geom.sec.ref_minC + 1) / 2
        end if
    end if

    ! Find width of cross-section
    width = (2.0d0*para_rad_helix + para_gap_helix) * dble(n_column)
end function ModGeo_Set_Width_Section

! -----------------------------------------------------------------------------

! Set geometric scale
subroutine ModGeo_Set_Scale_Geometry(geom, scale)
    type(GeomType),   intent(inout) :: geom
    double precision, intent(in)    :: scale

    integer :: i

    ! Rescale the modified edge length
    ! para_init_scale is initial scale factor from input
    do i = 1, geom.n_modP
        geom.modP(i).pos(1:3) = geom.modP(i).pos(1:3) * scale
    end do

    ! Rescale initial points
    do i = 1, geom.n_iniP
        geom.iniP(i).pos(1:3) = geom.iniP(i).pos(1:3) * scale
    end do
end subroutine ModGeo_Set_Scale_Geometry

! -----------------------------------------------------------------------------

! Write modified geometry
subroutine ModGeo_Chimera_Mod_Geometry(prob, geom, mode)
    type(ProbType), intent(in) :: prob
    type(GeomType), intent(in) :: geom
    character(*),   intent(in) :: mode

    double precision :: length, pos_1(3), pos_2(3), pos_c(3), local(3,3)
    integer :: i
    logical :: f_axis, f_info
    character(200) :: path

    if(para_write_303 == .false.) return

    ! Set option
    f_axis = para_chimera_axis
    f_info = para_chimera_303_info

    path = trim(prob.path_work)//"/"//trim(prob.name_file)
    open(unit=303, file=trim(path)//"_03_sep_lines.bild", form="formatted")

    ! Write modified points
    write(303, "(a)"), ".color red"
    do i = 1, geom.n_modP
        write(303, "(a$   )"), ".sphere "
        write(303, "(4f9.3)"), geom.modP(i).pos(1:3), 0.35d0
    end do

    ! Write modified edges
    write(303, "(a)"), ".color dark green"
    do i = 1, geom.n_iniL

        pos_1(1:3) = geom.modP(geom.iniL(i).poi(1)).pos(1:3)
        pos_2(1:3) = geom.modP(geom.iniL(i).poi(2)).pos(1:3)

        write(303, "(a$   )"), ".cylinder "
        write(303, "(7f9.3)"), pos_1(1:3), pos_2(1:3), 0.15d0
    end do

    ! Information on edge and local coordinates
    if(f_info == .true.) then

        ! For points
        do i = 1, geom.n_modP
            write(303, "(a$   )"), ".cmov "
            write(303, "(3f9.3)"), geom.modP(i).pos(1:3) + 0.4d0
            write(303, "(a    )"), ".color red"
            write(303, "(a    )"), ".font Helvetica 12 bold"
            write(303, "(i7   )"), i
        end do

        ! For edges
        do i = 1, geom.n_iniL
            pos_1(1:3) = geom.modP(geom.iniL(i).poi(1)).pos(1:3)
            pos_2(1:3) = geom.modP(geom.iniL(i).poi(2)).pos(1:3)
            pos_c(1:3) = (pos_1(1:3) + pos_2(1:3)) / 2.0d0
            length     = Norm(pos_2 - pos_1)

            write(303, "(a$   )"), ".cmov "
            write(303, "(3f9.3)"), pos_c(1:3) + 0.4d0
            write(303, "(a    )"), ".color dark green"
            write(303, "(a    )"), ".font Helvetica 12 bold"
            !write(303, "(i7, a, f5.1, a)"), i, "(", length, ")"
            write(303, "(i7, a, f5.1, i, a)"), i, "("//&
                trim(adjustl(Dble2Str1(length)))//", "//&
                trim(adjustl(Int2Str(nint(length/para_dist_bp)+1)))//")"
        end do

        ! Local coordinate system on edges
        do i = 1, geom.n_iniL
            pos_1(1:3) = geom.modP(geom.iniL(i).poi(1)).pos(1:3)
            pos_2(1:3) = geom.modP(geom.iniL(i).poi(2)).pos(1:3)
            pos_c(1:3) = (pos_1(1:3) + pos_2(1:3)) / 2.0d0

            ! Local vectors
            local(1, 1:3) = geom.iniL(i).t(1, 1:3)
            local(2, 1:3) = geom.iniL(i).t(2, 1:3)
            local(3, 1:3) = geom.iniL(i).t(3, 1:3)

            write(303, "(a     )"), ".color red"     ! x-axis
            write(303, "(a$    )"), ".arrow "
            write(303, "(3f8.2$)"), pos_c(1:3)
            write(303, "(3f8.2$)"), pos_c(1:3) + local(1, 1:3) * 1.5d0
            write(303, "(3f8.2 )"), 0.18d0, 0.36d0, 0.6d0

            write(303, "(a     )"), ".color blue"    ! y-axis
            write(303, "(a$    )"), ".arrow "
            write(303, "(3f8.2$)"), pos_c(1:3)
            write(303, "(3f8.2$)"), pos_c(1:3) + local(2, 1:3) * 1.2d0
            write(303, "(3f8.2 )"), 0.18d0, 0.36d0, 0.6d0

            write(303, "(a     )"), ".color yellow"  ! z-axis
            write(303, "(a$    )"), ".arrow "
            write(303, "(3f8.2$)"), pos_c(1:3)
            write(303, "(3f8.2$)"), pos_c(1:3) + local(3, 1:3) * 1.2d0
            write(303, "(3f8.2 )"), 0.18d0, 0.36d0, 0.6d0
        end do
    end if

    ! Write global axis
    if(f_axis == .true.) then
        write(303, "(a)"), ".translate 0.0 0.0 0.0"
        write(303, "(a)"), ".scale 0.5"
        write(303, "(a)"), ".color grey"
        write(303, "(a)"), ".sphere 0 0 0 0.5"      ! Center
        write(303, "(a)"), ".color red"             ! x-axis
        write(303, "(a)"), ".arrow 0 0 0 4 0 0 "
        write(303, "(a)"), ".color blue"            ! y-axis
        write(303, "(a)"), ".arrow 0 0 0 0 4 0 "
        write(303, "(a)"), ".color yellow"          ! z-axis
        write(303, "(a)"), ".arrow 0 0 0 0 0 4 "
    end if
    close(unit=303)

    ! ---------------------------------------------
    !
    ! Write the file for Tecplot
    !
    ! ---------------------------------------------
    if(para_output_Tecplot == "off") return

    path = trim(prob.path_work)//"/tecplot/"//trim(prob.name_file)
    open(unit=303, file=trim(path)//"_03_sep_lines.dat", form="formatted")

    write(303, "(a )"), 'TITLE = "'//trim(prob.name_file)//'"'
    write(303, "(a )"), 'VARIABLES = "X", "Y", "Z", "t1", "t2", "t3"'
    write(303, "(a$)"), 'ZONE F = FEPOINT'
    write(303, "(a$)"), ', N='//trim(adjustl(Int2Str(geom.n_modP)))
    write(303, "(a$)"), ', E='//trim(adjustl(Int2Str(geom.n_iniL)))
    write(303, "(a )"), ', ET=LINESEG'

    ! Write vertices
    do i = 1, geom.n_modP
        write(303, "(3f9.3$)"), geom.modP(i).pos(1:3)
        write(303, "(3f9.3 )"), 1.0d0, 1.0d0, 1.0d0
    end do

    ! Write edges
    do i = 1, geom.n_iniL
        write(303, "(2i7)"), geom.iniL(i).poi(1), geom.iniL(i).poi(2)
    end do

    write(303, "(a )"), 'VARIABLES = "X", "Y", "Z", "t1", "t2", "t3"'
    write(303, "(a$)"), 'ZONE F = FEPOINT'
    write(303, "(a$)"), ', N='//trim(adjustl(Int2Str(geom.n_iniL)))
    write(303, "(a$)"), ', E='//trim(adjustl(Int2Str(geom.n_iniL)))
    write(303, "(a )"), ', ET=LINESEG'

    ! Local coordinate system on edges
    do i = 1, geom.n_iniL
        pos_1(1:3) = geom.modP(geom.iniL(i).poi(1)).pos(1:3)
        pos_2(1:3) = geom.modP(geom.iniL(i).poi(2)).pos(1:3)
        pos_c(1:3) = (pos_1(1:3) + pos_2(1:3)) / 2.0d0

        write(303, "(3f9.3$)"), pos_c(1:3)
        write(303, "(3f9.3 )"), geom.iniL(i).t(1, 1:3)
    end do

    ! Write edges
    do i = 1, geom.n_iniL
        write(303, "(2i7)"), i, i
    end do

    write(303, "(a )"), 'VARIABLES = "X", "Y", "Z", "t1", "t2", "t3"'
    write(303, "(a$)"), 'ZONE F = FEPOINT'
    write(303, "(a$)"), ', N='//trim(adjustl(Int2Str(geom.n_iniL)))
    write(303, "(a$)"), ', E='//trim(adjustl(Int2Str(geom.n_iniL)))
    write(303, "(a )"), ', ET=LINESEG'

    ! Local coordinate system on edges
    do i = 1, geom.n_iniL
        pos_1(1:3) = geom.modP(geom.iniL(i).poi(1)).pos(1:3)
        pos_2(1:3) = geom.modP(geom.iniL(i).poi(2)).pos(1:3)
        pos_c(1:3) = (pos_1(1:3) + pos_2(1:3)) / 2.0d0

        write(303, "(3f9.3$)"), pos_c(1:3)
        write(303, "(3f9.3 )"), geom.iniL(i).t(2, 1:3)
    end do

    ! Write edges
    do i = 1, geom.n_iniL
        write(303, "(2i7)"), i, i
    end do

    write(303, "(a )"), 'VARIABLES = "X", "Y", "Z", "t1", "t2", "t3"'
    write(303, "(a$)"), 'ZONE F = FEPOINT'
    write(303, "(a$)"), ', N='//trim(adjustl(Int2Str(geom.n_iniL)))
    write(303, "(a$)"), ', E='//trim(adjustl(Int2Str(geom.n_iniL)))
    write(303, "(a )"), ', ET=LINESEG'

    ! Local coordinate system on edges
    do i = 1, geom.n_iniL
        pos_1(1:3) = geom.modP(geom.iniL(i).poi(1)).pos(1:3)
        pos_2(1:3) = geom.modP(geom.iniL(i).poi(2)).pos(1:3)
        pos_c(1:3) = (pos_1(1:3) + pos_2(1:3)) / 2.0d0

        write(303, "(3f9.3$)"), pos_c(1:3)
        write(303, "(3f9.3 )"), geom.iniL(i).t(3, 1:3)
    end do

    ! Write edges
    do i = 1, geom.n_iniL
        write(303, "(2i7)"), i, i
    end do

    close(unit=303)
end subroutine ModGeo_Chimera_Mod_Geometry

! -----------------------------------------------------------------------------

! Set the gap distance between the junction and end of edges
subroutine ModGeo_Set_Gap_Junction(geom, bound)
    type(GeomType),  intent(inout) :: geom
    type(BoundType), intent(inout) :: bound

    double precision :: dist_gap, length, remain
    double precision :: pos_cur(3), pos_opp(3), vec_a(3), vec_b(3)
    integer :: i, j, poi_cur, poi_1, poi_2, n_bp

    double precision :: pos_c(3), pos_1(3), pos_2(3)
    double precision :: ref_length, len_ini, len_mod, ratio
    integer :: ref_edge, iniP1, iniP2, modP1, modP2

    ! Loop for junction to modify gap distance
    do i = 1, bound.n_junc

        ! Find gap distance
        dist_gap = bound.junc(i).gap

        ! Modify the edge length
        do j = 1, bound.junc(i).n_arm

            ! Position vector of arm junction point
            poi_cur = bound.junc(i).modP(j)
            pos_cur = geom.modP(poi_cur).pos(1:3)

            poi_1 = geom.iniL(bound.junc(i).iniL(j)).poi(1)
            poi_2 = geom.iniL(bound.junc(i).iniL(j)).poi(2)

            ! Find point that is opposite to poi_cur
            if(poi_1 == poi_cur) then
                pos_opp(1:3) = geom.modP(poi_2).pos(1:3)
            else if(poi_2 == poi_cur) then
                pos_opp(1:3) = geom.modP(poi_1).pos(1:3)
            end if

            ! Original edge length
            length = Norm(pos_opp(1:3) - pos_cur(1:3))

            ! Find modified position vector
            vec_a(1:3) = dist_gap*pos_opp(1:3)
            vec_b(1:3) = (length-dist_gap)*pos_cur(1:3)
            geom.modP(poi_cur).pos(1:3) = (vec_a + vec_b)/length
        end do
    end do

    ! Print progress
    do i = 0, 11, 11
        call Space(i, 6)
        write(i, "(a)"), "2.8. Update edge length with the scale factor"
    end do

    do i = 1, geom.n_iniL
        poi_1  = geom.iniL(i).poi(1)
        poi_2  = geom.iniL(i).poi(2)
        length = Norm(geom.modP(poi_1).pos - geom.modP(poi_2).pos)
        n_bp   = nint(length / para_dist_bp) + 1
        remain = dmod(length, para_dist_bp)

        if(dmod(length, para_dist_bp) >= para_dist_bp/2.0d0) then
            remain = 0.0d0
        end if

        write(11, "(i20,  a$)"), i,      " th edge -> edge length : "
        write(11, "(f8.3, a$)"), length, " [nm] -> "
        write(11, "(i4,   a$)"), n_bp,   " BP, remaining length : "
        write(11, "(f8.3, a )"), remain, " [nm]"
    end do
    write(0, "(a)"); write(11, "(a)")
end subroutine ModGeo_Set_Gap_Junction

! -----------------------------------------------------------------------------

! Set constant modified edge ratio based on original geometry
subroutine ModGeo_Set_Const_Geometric_Ratio(geom)
    type(GeomType), intent(inout) :: geom

    double precision :: length, vec_a(3), vec_b(3), pos_c(3), pos_1(3), pos_2(3)
    double precision :: ref_length, len_ini, len_mod, len_new, len_ref, ratio, magic
    integer :: i, ref_edge, iniP1, iniP2, modP1, modP2

    ! Calculate magic depending on types of section
    if(geom.sec.types == "square")    magic = 0.0d0
    if(geom.sec.types == "honeycomb") magic = 0.34d0

    ! Find reference edge
    do i = 1, geom.n_iniL
        iniP1  = geom.iniL(i).poi(1)
        iniP2  = geom.iniL(i).poi(2)
        length = Norm(geom.modP(iniP1).pos - geom.modP(iniP2).pos)

        ! Find reference edge
        if(i == 1 .or. ref_length > length) then
            ref_length = length
            ref_edge   = i
        end if
    end do

    ! Find reference initial edge length
    iniP1   = geom.iniL(ref_edge).iniP(1)
    iniP2   = geom.iniL(ref_edge).iniP(2)
    len_ini = Norm(geom.iniP(iniP1).pos - geom.iniP(iniP2).pos)
    len_ref = len_ini

    modP1   = geom.iniL(ref_edge).poi(1)
    modP2   = geom.iniL(ref_edge).poi(2)
    len_mod = Norm(geom.modP(modP1).pos - geom.modP(modP2).pos)    
    ratio   = (len_mod + 0.34d0*2.0d0) / (len_ref)

    ! Rescale the edge with ratio
    do i = 1, geom.n_iniL

        ! Scaled initial edges
        iniP1   = geom.iniL(i).iniP(1)
        iniP2   = geom.iniL(i).iniP(2)
        len_ini = Norm(geom.iniP(iniP1).pos - geom.iniP(iniP2).pos)

        ! modified edges without constant constraints
        modP1   = geom.iniL(i).poi(1)
        modP2   = geom.iniL(i).poi(2)
        len_mod = Norm(geom.modP(modP1).pos - geom.modP(modP2).pos)

        pos_1(1:3) = geom.iniP(iniP1).pos(1:3)
        pos_2(1:3) = geom.iniP(iniP2).pos(1:3)
        pos_c(1:3) = 0.5d0 * (pos_1 + pos_2)

        vec_a(1:3) = Normalize(pos_1(1:3) - pos_c(1:3))
        vec_b(1:3) = Normalize(pos_2(1:3) - pos_c(1:3))

        ! Recalculate point position
        !geom.modP(modP1).pos(1:3) = pos_c(1:3) + vec_a(1:3) * (ratio * len_ini/2.0d0 - magic/2.0d0 + 0.05d0)
        !geom.modP(modP2).pos(1:3) = pos_c(1:3) + vec_b(1:3) * (ratio * len_ini/2.0d0 - magic/2.0d0 + 0.05d0)
        geom.modP(modP1).pos(1:3) = pos_c(1:3) + vec_a(1:3) * (ratio * (len_ini)/2.0d0 - 0.34d0)
        geom.modP(modP2).pos(1:3) = pos_c(1:3) + vec_b(1:3) * (ratio * (len_ini)/2.0d0 - 0.34d0)

        len_new = Norm(geom.modP(modP1).pos - geom.modP(modP2).pos)

        ! Print progress
        call space(0, 11)
        write(0, "(a$)"), trim(adjustl(Int2Str(i)))//" - th edge"
        write(0, "(a$)"), ", len(init) : "//trim(adjustl(Dble2Str(len_ini)))
        write(0, "(a$)"), " ["//trim(adjustl(Dble2Str(42.0d0*(len_ini/len_ref))))//"] "
        write(0, "(a$)"), ", len(mod) : "//trim(adjustl(Dble2Str(len_mod)))
        write(0, "(a$)"), " ["//trim(adjustl(Int2Str(nint(len_mod/0.34d0) + 2)))//"] "
        write(0, "(a$)"), ", len(new) : "//trim(adjustl(Dble2Str(len_new)))
        write(0, "(a )"), " ["//trim(adjustl(Int2Str(nint(len_new/0.34d0) + 2)))//"] "
    end do
end subroutine ModGeo_Set_Const_Geometric_Ratio

! -----------------------------------------------------------------------------

! Set modified edge length based on multiple of 10.5-bp length
subroutine ModGeo_Set_Round_Geometric_Ratio(prob, geom)
    type(ProbType), intent(in)    :: prob
    type(GeomType), intent(inout) :: geom

    double precision :: length, vec_a(3), vec_b(3), pos_c(3), pos_1(3), pos_2(3)
    double precision :: ref_length, len_ini1, len_ini2, len_mod, len_new, len_ref, ratio, magic
    integer :: i, ref_edge, iniP1, iniP2, modP1, modP2

    ! Calculate magic depending on types of section
    if(geom.sec.types == "square")    magic = 0.0d0
    if(geom.sec.types == "honeycomb") magic = 0.34d0

    ! Find reference edge
    do i = 1, geom.n_iniL
        iniP1  = geom.iniL(i).poi(1)
        iniP2  = geom.iniL(i).poi(2)
        length = Norm(geom.modP(iniP1).pos - geom.modP(iniP2).pos)

        ! Find reference edge
        if(i == 1 .or. ref_length > length) then
            ref_length = length
            ref_edge   = i
        end if
    end do

    ! Find ratio divied by initial edge length
    modP1    = geom.iniL(ref_edge).poi(1)
    modP2    = geom.iniL(ref_edge).poi(2)
    iniP1    = geom.iniL(ref_edge).iniP(1)
    iniP2    = geom.iniL(ref_edge).iniP(2)
    len_ini1 = Norm(geom.iniP(iniP1).pos - geom.iniP(iniP2).pos)
    len_mod  = Norm(geom.modP(modP1).pos - geom.modP(modP2).pos)
    len_ref  = len_ini1
    ratio    = (len_mod + magic) / len_ini1

    ! Rescale the edge with ratio
    do i = 1, geom.n_iniL
        iniP1 = geom.iniL(i).iniP(1)
        iniP2 = geom.iniL(i).iniP(2)
        modP1 = geom.iniL(i).poi(1)
        modP2 = geom.iniL(i).poi(2)

        pos_1(1:3) = geom.iniP(iniP1).pos(1:3)
        pos_2(1:3) = geom.iniP(iniP2).pos(1:3)
        pos_c(1:3) = 0.5d0 * (pos_1 + pos_2)
        len_ini1   = Norm(geom.iniP(iniP1).pos - geom.iniP(iniP2).pos)
        len_ini2   = len_ini1
        len_ini2   = ModGeo_Find_Round_Length(prob.n_bp_edge*(len_ini1/len_ref))*len_ref/prob.n_bp_edge
        len_mod    = Norm(geom.modP(modP1).pos - geom.modP(modP2).pos)

        vec_a(1:3) = Normalize(pos_1(1:3) - pos_c(1:3))
        vec_b(1:3) = Normalize(pos_2(1:3) - pos_c(1:3))

        ! Recalculate point position
        geom.modP(modP1).pos(1:3) = pos_c(1:3) + vec_a(1:3) * (prob.n_bp_edge*(len_ini2/len_ref) * 0.34d0 / 2.0d0 - 2.0d0*magic/2.0d0 + 0.0d0)
        geom.modP(modP2).pos(1:3) = pos_c(1:3) + vec_b(1:3) * (prob.n_bp_edge*(len_ini2/len_ref) * 0.34d0 / 2.0d0 - 2.0d0*magic/2.0d0 + 0.0d0)

        len_new = Norm(geom.modP(modP1).pos - geom.modP(modP2).pos)

        ! Print progress
        call space(0, 11)
        write(0, "(a16$)"), trim(adjustl(Int2Str(i)))//" - edge length"
        write(0, "(a$)"), ", Init1: "//trim(adjustl(Dble2Str(len_ini1)))
        write(0, "(a$)"), " ["//trim(adjustl(Dble2Str(prob.n_bp_edge*(len_ini1/len_ref))))//"]"
        write(0, "(a$)"), ", Init2: "//trim(adjustl(Dble2Str(len_ini2)))
        write(0, "(a$)"), " ["//trim(adjustl(Dble2Str(prob.n_bp_edge*(len_ini2/len_ref))))//"]"
        write(0, "(a$)"), "], Mod: "//trim(adjustl(Dble2Str(len_mod)))
        write(0, "(a$)"), " ["//trim(adjustl(Int2Str(nint(len_mod/0.34d0) + 1)))//"]"
        write(0, "(a$)"), ", New: "//trim(adjustl(Dble2Str(len_new)))
        write(0, "(a )"), " ["//trim(adjustl(Int2Str(nint(len_new/0.34d0) + 1)))//"]"
    end do
end subroutine ModGeo_Set_Round_Geometric_Ratio

! -----------------------------------------------------------------------------

! Find round up edge length
function ModGeo_Find_Round_Length(len_in) result(len_out)
    double precision, intent(in) :: len_in

    double precision :: len_out

    len_out = dble(floor(idnint(len_in / 10.5d0)*10.5d0))
end function

! -----------------------------------------------------------------------------

end module ModGeo