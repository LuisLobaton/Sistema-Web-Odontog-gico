
package main

import rego.v1

# Recursos AWS que deben tener la etiqueta Project.
taggable_types := {
    "aws_vpc",
    "aws_launch_template",
    "aws_db_instance",
    "aws_db_subnet_group",
    "aws_s3_bucket",
    "aws_cloudfront_distribution",
    "aws_lb",
    "aws_lb_target_group",
    "aws_security_group",
    "aws_secretsmanager_secret",
    "aws_iam_role",
    "aws_iam_instance_profile"
}

# Comprobar la etiqueta Project en recursos convencionales.
deny contains msg if {
    some rc in input.resource_changes
    rc.type in taggable_types
    rc.change.after != null

    tags := object.union(
        object.get(rc.change.after, "tags", {}),
        object.get(rc.change.after, "tags_all", {})
    )

    object.get(tags, "Project", "") == ""

    msg := sprintf(
        "El recurso %s no tiene la etiqueta obligatoria Project",
        [rc.address]
    )
}

# Comprobar la etiqueta Project en Auto Scaling Groups.
deny contains msg if {
    some rc in input.resource_changes
    rc.type == "aws_autoscaling_group"
    rc.change.after != null

    not has_project_tag(
        object.get(rc.change.after, "tag", [])
    )

    msg := sprintf(
        "El Auto Scaling Group %s no tiene la etiqueta Project",
        [rc.address]
    )
}

has_project_tag(tags) if {
    some tag in tags
    tag.key == "Project"
    tag.value != ""
}
