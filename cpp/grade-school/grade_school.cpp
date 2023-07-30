#include "grade_school.hpp"

namespace grade_school {

void school::add(StudentName name, GradeYear grade) {
    school_roster[grade].push_back(name);
    std::sort(school_roster.at(grade).begin(), school_roster.at(grade).end());
}

SchoolRoster school::roster() const { return school_roster; }

StudentList school::grade(GradeYear grade) const {
    return school_roster.find(grade)->second;
}

} // namespace grade_school
