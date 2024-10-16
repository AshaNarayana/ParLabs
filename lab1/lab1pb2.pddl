(define (problem lab1pb2)
    (:domain blocksworld)
    (:objects
        a b c d
    )

    (:init
        (arm-empty)
        (on-table a)
        (on-table b)
        (on-table c)
        (clear a)
        (clear b)
        (on d c)
        (clear d)
    )

    (:goal
        (and
            (on-table d)(on b d) (on a b) (clear a) (on-table c) (clear c)
        )
    )

    ;un-comment the following line if metric is needed
    ;(:metric minimize (???))
)