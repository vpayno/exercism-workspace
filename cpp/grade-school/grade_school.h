#if !defined(GRADE_SCHOOL_H)
#define GRADE_SCHOOL_H

#include <algorithm>
#include <map>
#include <string>
#include <vector>

using GradeYear = int;
using StudentName = std::string;
using StudentList = std::vector<StudentName>;
using SchoolRoster = std::map<GradeYear, StudentList>;
using GradeRoster = std::pair<GradeYear, StudentList>;

namespace grade_school {

struct compare {
  public:
    compare(const int &search) : key(search) {}

    bool operator()(const GradeRoster &search) const {
        return search.first == key;
    }

  private:
    int key;
};

class school {
  public:
    school() = default;
    void add(StudentName name, GradeYear grade);
    [[nodiscard]] SchoolRoster roster() const;

    // one test doesn't use the return value for grade()
    // NOLINTNEXTLINE(modernize-use-nodiscard)
    StudentList grade(GradeYear grade) const;

  private:
    mutable SchoolRoster school_roster{};
};

} // namespace grade_school

#endif // GRADE_SCHOOL_H
