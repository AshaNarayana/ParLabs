(define (problem droneRescueProblem)
    (:domain droneRescueDomain)
    (:objects
        drone person1 person2 person3 d11 d12 d13 d14 d21 d22 d23 d24 d31 d32 d33 d34 d41 d42 d43 d44
    )

    (:init
        (drone-empty)
        (safe-zone d42)
        (person d14)
        (person d21)
        (person d22)
        (obstacle d23)
        (obstacle d33)
        (obstacle d44)
    )

    (:goal
        (and
            ;todo: put the goal condition here
        )
    )

    ;un-comment the following line if metric is needed
    ;(:metric minimize (???))
)